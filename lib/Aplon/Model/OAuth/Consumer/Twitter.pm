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
