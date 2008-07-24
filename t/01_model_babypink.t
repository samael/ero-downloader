use strict;
use Test::More tests => 5;
use Test::Exception;

BEGIN { use_ok 'Downloader::Model::Babypink' }

my $model = Downloader::Model::Babypink->new({debug => 1});
isa_ok $model, 'Downloader::Model::Babypink';
is $model->site_name, 'babypink', 'site_name';
is $model->site->title, 'babypink', 'site.title';
lives_ok { $model->fetch_douga_urls(); }
    'implemented fetch_douga_urls()';

