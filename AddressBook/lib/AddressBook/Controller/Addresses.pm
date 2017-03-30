package AddressBook::Controller::Addresses;
use Moose;
use namespace::autoclean;

use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }


sub add :Local {
    my ($self, $c) = @_;
    
    my $params = $c->req->params;
    my $user_id = $params->{user_id};
#    die unless $user_id && $user_id =~ /^\d+$/;
    my $user = $c->model('DB::User')->find( { id => $user_id } );
   
    $c->stash(user => $user);
   
    if (lc $c->req->method eq 'post' && $user && $params->{city} && $params->{street} && $params->{phone} && $params->{zipcode} ) {
        
        die "Bad city" if $params->{city} !~ /^\w+$/;
        die "Bad street" if $params->{street} !~ /^[A-Za-z0-9\s.,\/_+-]+$/;
        die "Bad phone" if $params->{phone} !~ /^\d{10}$/;
        die "Bad zipcode" if $params->{zipcode} !~ /^\d{6}$/;
        
        
        my $address = $c->model('DB::Address')->create(
            {
                user_id => $user->id,
                city => $params->{city},              
                street => $params->{street},
                phone => $params->{phone},
                zipcode => $params->{zipcode}
            }
        );    
        
        return $c->res->redirect($c->uri_for_action('users/index'));
    }   
}


sub base : Chained('') :PathPart('addresses') :CaptureArgs(1) {
    my ( $self, $c, $addressid ) = @_;
    
    die unless $addressid;
         
    my $user_id = $c->req->params->{user_id};
    my $user = $c->model('DB::User')->find( { id => $user_id } ); 
            
    my $address = $c->model('DB::Address')->find({ id => $addressid });
    my $addresses_all = $c->model('DB::Address')->search( {}, { order_by => 'id'} );  
    
   # my $user = $address->user;
    $c->stash( addresses_all => $addresses_all, address => $address, user => $user );
}


sub edit :Chained('base') :PathPart('edit') :Args(0)  {
    my ($self, $c) = @_;
    
    
    my $user = $c->stash->{user}; 
    my $address = $c->stash->{address};   
    my $params = $c->req->params;
    if ( lc $c->req->method eq 'post'  && $params->{city} && $params->{street} && $params->{phone} && $params->{zipcode} ) {
        
        die "Bad city" if $params->{city} !~ /^\w+$/;
        die "Bad street" if $params->{street} !~ /^[A-Za-z0-9\s.,\/_+-]+$/;
        die "Bad phone" if $params->{phone} !~ /^\d{10}$/;
        die "Bad zipcode" if $params->{zipcode} !~ /^\d{6}$/;
        
        
        $address->update(
            {
                city => $params->{city},              
                street => $params->{street},
                phone => $params->{phone},
                zipcode => $params->{zipcode}
            }
        );    
        return $c->res->redirect( $c->uri_for( $c->controller('Users')->action_for('view'), [ $user->id ] ) );
    }   
}


sub delete :Chained('base') :PathPart('delete') :Args(0)  {
    my ($self, $c) = @_;
    
    my $params = $c->req->params;
    my $user = $c->stash->{user};
    my $address = $c->stash->{address}; 
    
    if ( $address ) {
        eval {
            $address->delete;
        };
        if ($@) {
            warn "Smth wrong while delete!";
        }
        
        return $c->res->redirect($c->uri_for_action('users/index'));
    }   
}

=head1 AUTHOR

elik,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
