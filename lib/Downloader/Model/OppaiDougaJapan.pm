package Downloader::Model::OppaiDougaJapan;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use base qw(Downloader::Model::Base);

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    $self->site_name('oppai douga japan');
}

sub fetch_douga_urls {
    my $self = shift;

    $self->SUPER::fetch_douga_urls({
        page_selector      => 'div.free_con_txt ul li a',
        page_filter_regex  => qr/loli\.movie-japan\.com\/movie-list/,
        douga_selector     => 'p.down a',
        douga_filter_regex => qr/\.zip/,
    });
}

1;

