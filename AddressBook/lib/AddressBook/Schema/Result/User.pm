use utf8;
package AddressBook::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

AddressBook::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 lastname

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "lastname",
  { data_type => "varchar", is_nullable => 1, size => 50 },
   "username",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "email_address",
  { data_type => "text", is_nullable => 0, size => 200 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 50 },

);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");



# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-27 19:09:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Auh08Hs6hIzbF8da6Oy/7Q

__PACKAGE__->has_many(addresses =>  'AddressBook::Schema::Result::Address', 'user_id' );
__PACKAGE__->has_many(roles => 'AddressBook::Schema::Result::UserRole',  'user_id' );  #

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;

sub is_admin {
    my $self = shift;
    return $self->result_source->schema->resultset( 'UserRole' )->search( { user_id => $self->id, role_id => 2 } )->count;
}

sub user_roles {
    my $self = shift;
    warn "111111\n";
    my @roles_rs = $self->result_source->schema->resultset( 'UserRole' )->search( { user_id => $self->id } )->all;
    return \@roles_rs;
}

1;
