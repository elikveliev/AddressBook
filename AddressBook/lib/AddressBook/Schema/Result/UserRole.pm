use utf8;
package AddressBook::Schema::Result::UserRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AddressBook::Schema::Result::UserRole

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

=head1 TABLE: C<user_roles>

=cut

__PACKAGE__->table("user_roles");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=item * L</role_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id", "role_id");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-04-08 13:46:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3yTpNgH85SNrWWedw5R8Uw

__PACKAGE__->belongs_to(user => 'AddressBook::Schema::Result::User', { 'foreign.id' => 'self.user_id' }, );
__PACKAGE__->belongs_to(role => 'AddressBook::Schema::Result::Role', { 'foreign.id' => 'self.role_id' }, );

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
