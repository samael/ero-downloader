#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use File::Spec;
use lib File::Spec->catfile( $FindBin::Bin, qw/.. schema lib/ );

use Path::Class qw/file dir/;
use DBIx::Class::Schema::Loader qw/make_schema_at/;

my @arg = defined @ARGV ? @ARGV : qw();

die unless @arg;

# do manual delete instead of really_erase_my_files option
#    for keep MyApp/Schema.pm
my $libdir = dir($FindBin::Bin, '..', 'lib');
#if (-d $libdir) {
#    $libdir->rmtree;
#}

make_schema_at(
    'Downloader::Schema',
    {   components => [ 'ResultSetManager', 'UTF8Columns' ],
        dump_directory => File::Spec->catfile( $FindBin::Bin, '..', 'lib' ),
        debug          => 1,
    },
    \@arg,
);

1;
