package Downloader::Model::NakadashiBaby;
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use base qw(Downloader::Model::Base);

sub init {
    my $self = shift;
    $self->SUPER::init(@_);
    $self->site_name('nakadashi baby');
}

sub fetch_douga_urls {
    my $self = shift;

    $self->SUPER::fetch_douga_urls({
        page_selector      => 'div.text p a',
        page_filter_regex  => qr/www\.nakadashi\.to/,
        douga_selector     => 'div#image p a',
        douga_filter_regex => qr/\.zip/,
    });
}

1;

