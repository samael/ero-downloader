use strict;
use Test::More tests => 5;
use Test::Exception;

BEGIN { use_ok 'Downloader::Model::Cpz' }

my $model = Downloader::Model::Cpz->new({debug => 1});
isa_ok $model, 'Downloader::Model::Cpz';
is $model->site_name, 'cpz', 'site_name';
is $model->site->title, 'cpz', 'site.title';
lives_ok { $model->fetch_douga_urls(); }
    'implemented fetch_douga_urls()';

