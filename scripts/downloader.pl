#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use Getopt::Long;
use LWP::UserAgent;

use lib "$FindBin::Bin/../lib";
use Downloader::Schema;

my %opts;
if (!GetOptions(
    \%opts,
    'dir=s', 'quiet', 'verbose',
)) {
    die;
}

if ($opts{dir}) {
    unless (-d $opts{dir})  {
        !system("mkdir -p $opts{dir}")
            or die "Cannot mkdir -p $opts{dir}: $!";
    }
    do_work();
}
else {
    print "Usage: downloader.pl --dir 'directory to save\n";
    exit(1);
}

sub debug_print {
    print STDERR @_ if $opts{verbose};
}

sub user_agent {
    return LWP::UserAgent->new(
        agent => 'Mozilla/5.0',
    );
}

sub do_work {
    my $schema = Downloader::Schema->connect(
        'dbi:SQLite:db/downloader.db',
        { RaiseError => 1 }
    ) or die;

    my $douga_rs = $schema->resultset('Douga')->search(
        { downloaded => 0
        },
        { order_by => 'id ASC'
        },
    );

    my $options = sprintf('--directory-prefix=%s', $opts{dir});
    if ($opts{quiet}) {
        $options .= ' --quiet';
    }

    my $ua = user_agent();
    while (my $douga = $douga_rs->next) {
        my $url = $douga->url;
        debug_print($url, "\n");
        my $command = sprintf('wget %s --referer=%s %s', $options, $douga->referer, $url);
        !system($command)
            or debug_print("Cannot wget $url: $?");
            #or die "Cannot wget $url: $?";
        $douga->update({
            downloaded => 1,
        });
    }
}

