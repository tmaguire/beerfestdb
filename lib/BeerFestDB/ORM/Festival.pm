use utf8;
package BeerFestDB::ORM::Festival;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BeerFestDB::ORM::Festival

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<festival>

=cut

__PACKAGE__->table("festival");

=head1 ACCESSORS

=head2 festival_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 year

  data_type: 'year'
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 fst_start_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 fst_end_date

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "festival_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "year",
  { data_type => "year", is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "fst_start_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "fst_end_date",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</festival_id>

=back

=cut

__PACKAGE__->set_primary_key("festival_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<name>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("name", ["name"]);

=head1 RELATIONS

=head2 bars

Type: has_many

Related object: L<BeerFestDB::ORM::Bar>

=cut

__PACKAGE__->has_many(
  "bars",
  "BeerFestDB::ORM::Bar",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 cask_managements

Type: has_many

Related object: L<BeerFestDB::ORM::CaskManagement>

=cut

__PACKAGE__->has_many(
  "cask_managements",
  "BeerFestDB::ORM::CaskManagement",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 festival_openings

Type: has_many

Related object: L<BeerFestDB::ORM::FestivalOpening>

=cut

__PACKAGE__->has_many(
  "festival_openings",
  "BeerFestDB::ORM::FestivalOpening",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 festival_products

Type: has_many

Related object: L<BeerFestDB::ORM::FestivalProduct>

=cut

__PACKAGE__->has_many(
  "festival_products",
  "BeerFestDB::ORM::FestivalProduct",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 measurement_batches

Type: has_many

Related object: L<BeerFestDB::ORM::MeasurementBatch>

=cut

__PACKAGE__->has_many(
  "measurement_batches",
  "BeerFestDB::ORM::MeasurementBatch",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 order_batches

Type: has_many

Related object: L<BeerFestDB::ORM::OrderBatch>

=cut

__PACKAGE__->has_many(
  "order_batches",
  "BeerFestDB::ORM::OrderBatch",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);

=head2 stillage_locations

Type: has_many

Related object: L<BeerFestDB::ORM::StillageLocation>

=cut

__PACKAGE__->has_many(
  "stillage_locations",
  "BeerFestDB::ORM::StillageLocation",
  { "foreign.festival_id" => "self.festival_id" },
  undef,
);


# Created by DBIx::Class::Schema::Loader v0.07039 @ 2014-07-20 17:33:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hzo67vQShRe9KA/Z+t/rBw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->many_to_many(
    "products" => "festival_products", "product_id"
);

sub repr {
    my ( $self ) = @_; return $self->name;
}

1;
