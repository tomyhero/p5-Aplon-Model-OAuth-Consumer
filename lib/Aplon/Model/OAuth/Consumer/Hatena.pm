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
