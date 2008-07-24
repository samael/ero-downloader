package Downloader::Model::Babypink;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use base qw(Downloader::Model::Base);

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    $self->site_name('babypink');
}

sub fetch_douga_urls {
    my $self = shift;

    $self->SUPER::fetch_douga_urls({
        page_selector      => 'span.text12line a',
        page_filter_regex  => qr/www\.babypink\.to/,
        douga_selector     => 'div.sample_line table tr td a',
        douga_filter_regex => qr/\.zip/,
    });
}

1;

