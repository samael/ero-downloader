#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use Getopt::Long;

use lib "$FindBin::Bin/../lib";
use Downloader::Model::Babypink;
use Downloader::Model::NakadashiBaby;
use Downloader::Model::Cpz;
use Downloader::Model::OppaiDougaJapan;

my %opts = (
    debug => 0,
);

if (!GetOptions(
    \%opts,
    'debug',
)) {
    die;
}

do_work();

sub do_work {
    foreach my $type (qw(Babypink NakadashiBaby Cpz OppaiDougaJapan)) {
        my $class = "Downloader::Model::$type";
        my $model = $class->new({debug => $opts{debug}});
        $model->fetch_douga_urls();
    }
}

