package Downloader::Model::Cpz;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use base qw(Downloader::Model::Base);

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    $self->site_name('cpz');
}

sub fetch_douga_urls {
    my $self = shift;

    $self->SUPER::fetch_douga_urls({
        page_selector      => 'div.free_sam_mov ul li a',
        page_filter_regex  => qr/cpz\.to/,
        douga_selector     => 'div.play_mini_r a',
        douga_filter_regex => qr/\.zip/,
    });
}

1;

