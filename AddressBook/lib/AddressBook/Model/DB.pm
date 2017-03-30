package AddressBook::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'AddressBook::Schema',
    
    connect_info => {
        dsn => 'dbi:mysql:AddressBook',
        user => 'elik',
        password => 'elik',
    }
);

=head1 NAME

AddressBook::Model::DB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<AddressBook>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<AddressBook::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

elik

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;