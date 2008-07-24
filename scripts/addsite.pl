#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use Getopt::Long;

use lib "$FindBin::Bin/../lib";
use Downloader::Schema;

my ($title, $url);
if (!GetOptions(
    'title=s' => \$title,
    'url=s'   => \$url,
)) {
    die;
}

if ($title && $url) {
    do_work();
}
else {
    print "Usage: addsite.pl --title 'site title' --url 'site url\n";
    exit(1);
}

sub do_work {
    my $schema = Downloader::Schema->connect(
        'dbi:SQLite:db/downloader.db',
        { RaiseError => 1 }
    );
    my $site = $schema->resultset('Sites')->find_or_create({
        title => $title,
        url => $url,
        updated_at => \"datetime('now')",
        created_at => \"datetime('now')",
    });
    if (defined $site) {
        printf 'created: %s(%s)', $site->title, $site->url;
    }
    else {
        print "failed\n";
    }
}

