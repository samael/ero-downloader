use strict;
use Test::More tests => 5;
use Test::Exception;

BEGIN { use_ok 'Downloader::Model::NakadashiBaby' }

my $model = Downloader::Model::NakadashiBaby->new({debug => 1});
isa_ok $model, 'Downloader::Model::NakadashiBaby';
is $model->site_name, 'nakadashi baby', 'site_name';
is $model->site->title, 'nakadashi baby', 'site.title';
lives_ok { $model->fetch_douga_urls(); }
    'implemented fetch_douga_urls()';

