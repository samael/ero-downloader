use strict;
use Test::More tests => 2;

BEGIN { use_ok 'Downloader::Model::Base' }

my $model = Downloader::Model::Base->new();
isa_ok $model, 'Downloader::Model::Base';

