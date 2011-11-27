package Aplon::Model::OAuth::Consumer;
use strict;
use Mouse;
use OAuth::Lite::Consumer;

extends 'Aplon';
with 'Aplon::Validator::Simple';
our $VERSION = '0.01';

# for consumer instance
has 'consumer_key' => ( is => 'rw', required => 1);
has 'consumer_secret' => ( is => 'rw', required => 1);
has 'site' => ( is => 'rw', required => 1);
has 'request_token_path' => ( is => 'rw', required => 1);
has 'access_token_path' => ( is => 'rw', required => 1);
has 'authorize_path' => ( is => 'rw', required => 1);

has 'consumer' => (
    is => 'rw',
    lazy_build => 1,
);

has 'session' => ( is => 'rw', required => 1 );

sub _build_consumer {
    my $self = shift;
    return OAuth::Lite::Consumer->new(
    consumer_key       => $self->consumer_key,
    consumer_secret    => $self->consumer_secret,
    site               => $self->site,
    request_token_path => $self->request_token_path,
    access_token_path  => $self->access_token_path,
    authorize_path     => $self->authorize_path,
);
}

sub oauth {
    my $self = shift;
    my $args = shift || {};

    my $consumer = $self->consumer;

    my $request_token 
        = $consumer->get_request_token(%$args) or
            $self->abort_with({ 
                code => 'OAUTH_FAILED', 
                custom_invalid => 'get_request_token_faild', 
                message => $consumer->errstr }
            );
    
    $self->session->set($self->request_token_key => $request_token);     

    return $consumer->url_to_authorize( token => $request_token);     
}

sub callback {
    my $self = shift;
    my $args = shift || {};
    my $consumer = $self->consumer;

    my $access_token 
        = $consumer->get_access_token(
            token    => $self->session->get($self->request_token_key) || '',
            verifier => $args->{oauth_verifier} || '') or 
                $self->abort_with({ 
                    code => 'OAUTH_FAILED', 
                    custom_invalid => 'get_access_token_faild', 
                    message => $consumer->errstr }
                );

    $self->session->remove($self->request_token_key);

    return $self->do_complate( $access_token );
}

sub do_complate {
    my $self = shift;
    my $access_token = shift ; 
    die 'do_complate() is ABSTRACT method';
}

sub request_token_key {
    my $self = shift;
    return ref ($self) . '::request_token';
}



__PACKAGE__->meta->make_immutable();

no Mouse;

1;

=head1 NAME 

Aplon::Model::OAuth::Consumer - help you to create OAuth consumer logic.

=head1 DESCRIPTION

OAuth. SEE  L<Aplon::Model::OAuth::Twitter> or L<Aplon::Model::OAuth::Hatena> document for how to use.

=head1 AUTHOR

Tomohiro Teranishi 

=head1 SEE ALSO

L<Aplon>

L<OAuth::Lite>

L<Aplon::Model::OAuth::Hatena>

L<Aplon::Model::OAuth::Twitter>

=cut
