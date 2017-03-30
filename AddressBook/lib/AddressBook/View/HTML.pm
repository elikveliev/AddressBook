package AddressBook::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    # Change default TT extension
    TEMPLATE_EXTENSION => '.tt2',
    render_die => 1,
    WRAPPER => 'wrapper.tt2',
);



=head1 NAME

AddressBook::View::HTML - TT View for AddressBook

=head1 DESCRIPTION

TT View for AddressBook.

=head1 SEE ALSO

L<AddressBook>

=head1 AUTHOR

elik,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
