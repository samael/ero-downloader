use inc::Module::Install;

name 'Downloader';
all_from 'lib/Downloader.pm';

build_requires 'Test::More';

requires 'URI';
requires 'Path::Class';
requires 'LWP::UserAgent';
requires 'Web::Scraper';
requires 'DBD::SQLite';
requires 'DBIx::Class';
requires 'DBIx::Class::Schema::Loader';

auto_include;
WriteAll;

