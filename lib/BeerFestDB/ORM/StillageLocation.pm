use utf8;
package BeerFestDB::ORM::StillageLocation;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BeerFestDB::ORM::StillageLocation

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<stillage_location>

=cut

__PACKAGE__->table("stillage_location");

=head1 ACCESSORS

=head2 stillage_location_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 festival_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=cut

__PACKAGE__->add_columns(
  "stillage_location_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "festival_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</stillage_location_id>

=back

=cut

__PACKAGE__->set_primary_key("stillage_location_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<festival_id>

=over 4

=item * L</festival_id>

=item * L</description>

=back

=cut

__PACKAGE__->add_unique_constraint("festival_id", ["festival_id", "description"]);

=head1 RELATIONS

=head2 cask_managements

Type: has_many

Related object: L<BeerFestDB::ORM::CaskManagement>

=cut

__PACKAGE__->has_many(
  "cask_managements",
  "BeerFestDB::ORM::CaskManagement",
  { "foreign.stillage_location_id" => "self.stillage_location_id" },
  undef,
);

=head2 festival_id

Type: belongs_to

Related object: L<BeerFestDB::ORM::Festival>

=cut

__PACKAGE__->belongs_to(
  "festival_id",
  "BeerFestDB::ORM::Festival",
  { festival_id => "festival_id" },
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-20 17:33:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LnVsenzG2vl1oQI9aXE2ug


# You can replace this text with custom content, and it will be preserved on regeneration
sub repr {
    my ( $self ) = @_; return $self->description;
}

1;
