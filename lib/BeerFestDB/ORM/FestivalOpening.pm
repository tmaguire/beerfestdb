use utf8;
package BeerFestDB::ORM::FestivalOpening;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BeerFestDB::ORM::FestivalOpening

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<festival_opening>

=cut

__PACKAGE__->table("festival_opening");

=head1 ACCESSORS

=head2 festival_opening_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 festival_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 op_start_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 op_end_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "festival_opening_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "festival_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "op_start_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "op_end_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</festival_opening_id>

=back

=cut

__PACKAGE__->set_primary_key("festival_opening_id");

=head1 RELATIONS

=head2 festival_entries

Type: has_many

Related object: L<BeerFestDB::ORM::FestivalEntry>

=cut

__PACKAGE__->has_many(
  "festival_entries",
  "BeerFestDB::ORM::FestivalEntry",
  { "foreign.festival_opening_id" => "self.festival_opening_id" },
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
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:p76jLxlPazTNTeriXiurRw


# You can replace this text with custom content, and it will be preserved on regeneration
sub repr {
    my ( $self ) = @_; return sprintf("%s: %s - %s",
				      $self->festival_id->repr(),
				      $self->op_start_date,
				      $self->op_end_date);
}

1;
