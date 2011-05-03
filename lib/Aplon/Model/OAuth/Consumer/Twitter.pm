package Aplon::Model::OAuth::Consumer::Twitter;
use strict;
use Mouse;
extends 'Aplon::Model::OAuth::Consumer';

has '+site' => ( default => 'https://api.twitter.com');
has '+request_token_path' => (default => '/oauth/request_token' );
has '+access_token_path' => (default => '/oauth/access_token' );
#has '+authorize_path' => ( default => 'https://api.twitter.com/oauth/authorize' ); 
has '+authorize_path' => ( default => 'https://api.twitter.com/oauth/authenticate' ); 


__PACKAGE__->meta->make_immutable();

no Mouse;

1;


=head1 NAME

Aplon::Model::OAuth::Consumer::Twitter - Twitter OAuth Model

=head1 SYNOPSIS

 package Zerg::Model::OAuth::Twitter;
 use strict;
 use Mouse;
 extends 'Aplon::Model::OAuth::Consumer::Twitter';
 
 has '+consumer_key' => ( default => 'xxxxxxxxxxxxxxxx' );
 has '+consumer_secret' => ( default => 'yyyyyyyyyyyyyyyyy' );
 
 has '+error_class' => (
     default => 'Zerg::Aplon::Error',
 );
 
 around 'oauth' => sub {
      my ($next, $self, $args) = @_;
      $args->{callback_url} ||= 'http://zerg.example.com/auth/oauth/complete/twitter/';
      my $res = $self->$next($args);
     return $res;
 };
 
 sub do_complate {
     my $self = shift;
     my $access_token = shift ;
     my $consumer = $self->consumer;
 
    # do something 
 }
 
 __PACKAGE__->meta->make_immutable();
 
 no Mouse;
 
 1;


 package YourController;
 
 # auth
 sub login {
     my ($self,$c) = @_;
     my $model = Zerg::Model::OAuth::Twitter->new({ session => $c->session });
     $c->redirect( $model->oauth() );
 }
 
 # callback
 sub complete {
     my ($self,$c) = @_;
     my $model = Zerg::Model::OAuth::Twitter->new({ session => $c->session });
     $model->callback( $c->req->as_fdat );
 }  

 1;
