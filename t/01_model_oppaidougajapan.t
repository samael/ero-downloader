use strict;
use Test::More tests => 5;
use Test::Exception;

BEGIN { use_ok 'Downloader::Model::OppaiDougaJapan' }

my $model = Downloader::Model::OppaiDougaJapan->new({debug => 1});
isa_ok $model, 'Downloader::Model::OppaiDougaJapan';
is $model->site_name, 'oppai douga japan', 'site_name';
is $model->site->title, 'oppai douga japan', 'site.title';
lives_ok { $model->fetch_douga_urls(); }
    'implemented fetch_douga_urls()';

