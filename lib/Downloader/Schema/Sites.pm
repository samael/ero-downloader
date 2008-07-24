package Downloader::Schema::Sites;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("ResultSetManager", "UTF8Columns", "Core");
__PACKAGE__->table("sites");
__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0, size => undef },
  "title",
  { data_type => "text", is_nullable => 0, size => undef },
  "url",
  { data_type => "text", is_nullable => 0, size => undef },
  "updated_at",
  { data_type => "datetime", is_nullable => 0, size => undef },
  "created_at",
  { data_type => "datetime", is_nullable => 0, size => undef },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint("title_unique", ["title"]);
__PACKAGE__->add_unique_constraint("url_unique", ["url"]);


# Created by DBIx::Class::Schema::Loader v0.04004 @ 2008-03-02 12:14:39
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:WGz99pB4o3Psk2tqCZiRZg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
