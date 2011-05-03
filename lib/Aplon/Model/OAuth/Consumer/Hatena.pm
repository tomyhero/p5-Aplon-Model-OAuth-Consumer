package Aplon::Model::OAuth::Consumer::Hatena;
use strict;
use Mouse;
extends 'Aplon::Model::OAuth::Consumer';

has '+site' => ( default => 'https://www.hatena.com');
has '+request_token_path' => (default => '/oauth/initiate' );
has '+access_token_path' => (default => '/oauth/token' );
has '+authorize_path' => ( default => 'https://www.hatena.ne.jp/oauth/authorize' ); #XXX PC


__PACKAGE__->meta->make_immutable();

no Mouse;

1;

=head1 NAME

Aplon::Model::OAuth::Consumer::Hatena - Hatena OAuth Model

=head1 SYNOPSIS

 package Zerg::Model::OAuth::Hatena;
 use strict;
 use Mouse;
 extends 'Aplon::Model::OAuth::Consumer::Hatena';
 
 has '+consumer_key' => ( default => 'xxxxxxxxxxxxxxxx' );
 has '+consumer_secret' => ( default => 'yyyyyyyyyyyyyyyyy' );
 
 has '+error_class' => (
     default => 'Zerg::Aplon::Error',
 );
 
 around 'oauth' => sub {
      my ($next, $self, $args) = @_;
      $args->{callback_url} ||= 'http://zerg.example.com/auth/oauth/complete/hatena/';
      $args->{scope} ||= 'read_public';
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
     my $model = Zerg::Model::OAuth::Hatena->new({ session => $c->session });
     $c->redirect( $model->oauth() );
 }
 
 # callback
 sub complete {
     my ($self,$c) = @_;
     my $model = Zerg::Model::OAuth::Hatena->new({ session => $c->session });
     $model->callback( $c->req->as_fdat );
 }  

 1;
