use utf8;
package AddressBook::Schema::Result::Address;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AddressBook::Schema::Result::Address

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<Addresses>

=cut

__PACKAGE__->table("public.\"Addresses\"");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 city

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 street

  data_type: 'text'
  is_nullable: 0

=head2 phone

  data_type: 'bigint'
  is_nullable: 0

=head2 zipcode

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "city",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "street",
  { data_type => "text", is_nullable => 0 },
  "phone",
  { data_type => "bigint", is_nullable => 0 },
  "zipcode",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-14 20:25:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xqkV3D/tEFSeNzjzwYWLxA
__PACKAGE__->belongs_to('user' => 'AddressBook::Schema::Result::User', 'user_id');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
