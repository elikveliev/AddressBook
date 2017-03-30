use strict;
use warnings;
use Test::More;


use Catalyst::Test 'AddressBook';
use AddressBook::Controller::Addresses;

ok( request('/addresses')->is_success, 'Request should succeed' );
done_testing();
