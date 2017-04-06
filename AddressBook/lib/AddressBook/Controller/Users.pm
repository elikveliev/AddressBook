package AddressBook::Controller::Users;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

AddressBook::Controller::Users - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub add :Local {
    my ($self, $c) = @_;
    
    my $params = $c->req->params;
    if ( $c->req->method eq  "POST" ) {

        die "bad first name" unless ($params->{firstname} && $params->{firstname} =~ /^[A-Za-z-]+$/);
        die "bad last name"  unless ($params->{lastname} && $params->{lastname} =~ /^[A-Za-z-]+$/);
        my $username = $params->{username};
        die "bad username $username" unless $username =~ /^[\s\w]{4,10}$/;
        die "username $username exists "  if $c->model('DB::User')->search({username => $username})->first;
        my $password = $params->{password};
        my $password_confirm = $params->{password_confirm};
        die "bad password " unless $password =~ /^[\s\w]{4,10}$/;
        die "incorrectpassword confirmation " unless $password eq $password_confirm;
        
        warn "Will create a user...\n";
        my $user = eval{ $c->model('DB::User')->create({
            firstname   => $params->{firstname},
            lastname    => $params->{lastname},
            username    => $username,
            password    => $password,
            
            }); };
        die $@ if $@ or !$user;
        $c->stash(user => $user);
        
        return $c->res->redirect($c->uri_for_action('users/index'));
    }
    
    
}

sub base : Chained('') :PathPart('users') :CaptureArgs(1) {
    my ( $self, $c, $userid ) = @_;
        
    die unless $userid && $userid =~ /^\d{1,6}$/;
    
    my $user = $c->model('DB::User')->find({ id => $userid });
    my $users_all = $c->model('DB::User')->search( {}, { order_by => 'id'} );  
    
    $c->stash( users_all => $users_all, user => $user );
}

=toImprove
sub viewgoogd : Chained('base')   :Args(1) {
    my ($self, $c, $userid) = @_;
    
    die unless $userid =~ /^\d{1,6}$/;
    
    $c->stash('template' => 'users/index.tt2');
    
    my $user = $c->stash->{users_all}->find({ id => $userid });
    
 
    die unless $user;
    
    my $addresses = $c->model('DB::Address')->search( { user_id => $user->id } );
    $c->stash(user => $user, addresses => $addresses );
}

=cut

sub view : Chained('base') :PathPart('view') :Args(0) {
    my ($self, $c) = @_;
    
    my $user = $c->stash->{user};
    die unless $user;
    
    my $addresses = $c->model('DB::Address')->search( { user_id => $user->id } );
    $c->stash(user => $user, addresses => $addresses, template => 'users/index.tt2');
}


sub edit : Chained('base') :PathPart('edit') :Args(0) {
    my ($self, $c) = @_;
    
    my $user = $c->stash->{user};
    die unless $user;
        
    if ( $c->req->method eq  "POST" ) {
        my $params = $c->req->params;
        die "bad first name" unless ($params->{firstname} && $params->{firstname} =~ /^[A-Za-z-]+$/);
        die "bad last name"  unless ($params->{lastname} && $params->{lastname} =~ /^[A-Za-z-]+$/);
        my $username = $params->{username};
        my $password = $params->{password};
        my $password_confirm = $params->{password_confirm};
        die "bad password " unless $password =~ /^[\s\w]{4,10}$/;
        die "incorrectpassword confirmation " unless $password eq $password_confirm; 
    
        
    
   
    
        $user->update({ firstname => $params->{firstname},
                       lastname => $params->{lastname},
                       username => $username,
                       password => $password
                       });
    }
    
   # my $addresses = $c->model('DB::Address')->search( { user_id => $user->id } );
    $c->stash(user => $user); #, addresses => $addresses,);
}


sub delete : Chained('base') :PathPart('delete') :Args(0) {
    my ($self, $c) = @_;
    
    
    my $user = $c->stash->{user};
    die unless $user;
    
    if ( $user ) {
        $user->delete;
    }
    
    return $c->res->redirect($c->uri_for_action('users/index'));
}


=deprecated
sub list :Path Args(0) {
    my ( $self, $c ) = @_;
    $c->stash('template' => 'users/list.tt2');

    my $users_all = $c->model('DB::User')->earch( {}, { order_by => 'id'} );  
    
    $c->stash( users_all => $users_all);   
}
=cut


sub index :PathPart('index') :Args(0) {
    my ( $self, $c ) = @_;
    
   my $users_all = $c->model('DB::User')->search( {}, { order_by => 'id'} ); 
   $c->stash( users_all =>  $users_all);
        
}


=encoding utf8

=head1 AUTHOR

elik,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
