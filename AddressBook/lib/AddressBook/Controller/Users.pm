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
    if ( $params->{firstname} && $params->{firstname} ) {
        die "bad first name" unless ($params->{firstname} && $params->{firstname} =~ /^[A-Za-z-]+$/);
        die "bad last name"  unless ($params->{lastname} && $params->{lastname} =~ /^[A-Za-z-]+$/);
        my $user = $c->model('DB::User')->create({ firstname => $params->{firstname}, lastname => $params->{lastname} });
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
    
    my $params = $c->req->params;
    if ( $params->{firstname} && $params->{firstname} ) {
        die "bad first name" unless ($params->{firstname} && $params->{firstname} =~ /^[A-Za-z-]+$/);
        die "bad last name"  unless ($params->{lastname} && $params->{lastname} =~ /^[A-Za-z-]+$/);
        $user->update({ firstname => $params->{firstname}, lastname => $params->{lastname} });
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
