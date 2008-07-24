package Downloader::Schema::Douga;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("ResultSetManager", "UTF8Columns", "Core");
__PACKAGE__->table("douga");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0, size => undef },
  "url",
  { data_type => "text", is_nullable => 0, size => undef },
  "site",
  { data_type => "text", is_nullable => 0, size => undef },
  "referer",
  { data_type => "text", is_nullable => 0, size => undef },
  "downloaded",
  { data_type => "integer", is_nullable => 0, size => undef },
  "updated_at",
  { data_type => "datetime", is_nullable => 0, size => undef },
  "created_at",
  { data_type => "datetime", is_nullable => 0, size => undef },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("url_unique", ["url"]);


# Created by DBIx::Class::Schema::Loader v0.04004 @ 2008-03-02 12:14:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zbFvcgeukMPNI86nOvkq9Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
