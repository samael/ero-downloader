package Downloader::Model::Base;
use strict;
use warnings;
use base qw(Class::Accessor::Fast);
use LWP::UserAgent;
use FindBin;
use Web::Scraper;
use URI;
use Carp qw(croak);

__PACKAGE__->mk_accessors($_) for qw(
    user_agent schema debug
    site_name site_obj
);

use lib "$FindBin::Bin/../lib";
use Downloader::Schema;

sub new {
    my $class = shift;

    my $self = $class->SUPER::new(@_);
    $self->init();

    return $self;
}

sub init {
    my $self = shift;

    my $user_agent = LWP::UserAgent->new(
        agent => 'Mozilla/5.0',
    );
    my $schema = Downloader::Schema->connect(
        'dbi:SQLite:db/downloader.db',
        { RaiseError => 1 }
    );

    $self->user_agent($user_agent);
    $self->schema($schema);
}

sub debug_print {
    my $self = shift;
    print STDERR @_ if $self->debug;
}

sub site {
    my $self = shift;

    unless ($self->site_obj) {
        my $site_name = $self->site_name;
        croak "site_name not set.\n" unless $site_name;
        my $site = $self->schema->resultset('Sites')->search(title => $site_name)->first;
        $self->site_obj($site);
    }

    return $self->site_obj;
}

sub scrape {
    my ($self, $url, $tree) = @_;
    my $uri = URI->new($url);
    my $scraper = scraper {
        process $tree, 'url[]' => '@href';
    };
    my $result;
    eval {
        $result = $scraper->scrape($uri);
    };
    if ($@) {
        return;
    }
    else {
        return $result->{url};
    }
}

sub url_filter {
    my ($self, $urls, $regex) = @_;

    my @filtered;

    URL:
    foreach my $url (@$urls) {
        next URL unless $url =~ /$regex/;
        push @filtered, $url;
    }

    return [sort @filtered];
}

sub save_douga_urls {
    my ($self, $referer, $urls) = @_;

    my $schema = $self->schema;
    my $site_name = $self->site_name;

    foreach my $url (@$urls) {
        $schema->resultset('Douga')->find_or_create({
            url => $url,
            site => $site_name,
            referer => $referer,
            downloaded => 0,
            updated_at => \"datetime('now')",
            created_at => \"datetime('now')",
        });
    }
}

=head2 fetch_douga_urls

    $self->SUPER::fetch_douga_urls({
        page_selector      => 'div.free_sam_mov ul li a',
        page_filter_regex  => 'cpz\.to',
        douga_selector     => 'div.play_mini_r a',
        douga_filter_regex => '\.zip',
    });

This method expect child class to override and call with some arguments.

=cut

sub fetch_douga_urls {
    my ($self, $args) = @_;

    my $site = $self->site;
    $self->debug_print('site url: ', $site->url, "\n");

    my $page_urls = $self->scrape($site->url, $args->{page_selector});
    $page_urls = $self->url_filter($page_urls, $args->{page_filter_regex});

    my @urls;
    foreach my $url (@$page_urls) {
        my $douga_urls = $self->scrape($url, $args->{douga_selector});
        next unless $douga_urls;
        $douga_urls = $self->url_filter($douga_urls, $args->{douga_filter_regex});
        $self->debug_print("$_\n") for @$douga_urls;
        $self->save_douga_urls($url, $douga_urls);
        push @urls, @$douga_urls;
    }

    return @urls;
}

1;

