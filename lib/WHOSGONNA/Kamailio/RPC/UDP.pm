package WHOSGONNA::Kamailio::RPC::UDP;
use 5.008001;
use strict;
use warnings;

use Moo;
#use MooX::Types::MooseLike::Base qw(:all);
use Types::Standard qw(:all);
use IO::Socket::INET;
use JSON;
use Const::Fast;

our $VERSION = "0.01";


## This is only made to use UDP (hey, it's in the module name...)
const my $proto   => 'udp';
const my $jsonrpc => '2.0';

## IP address or hostname of kamailio server
has kamailio_peer => (
    is       => 'ro',
    isa      => Str,
    required => 1,
    default  => 'localhost',
);


## Port number that kamailio's JSONRPCS module is using:
has kamailio_port => (
    is       => 'ro',
    required => 1,
    default  => 8090
);


## IO::Socket::INET object for handling communication:
has _sock => (
    is  => 'lazy',
    isa => InstanceOf['IO::Socket::INET']
);
## Lazy build of _sock
sub _build__sock {
    my $self = shift;
    my $sock =  IO::Socket::INET->new(
        Proto    => $proto,
        PeerAddr => $self->kamailio_peer,
        PeerPort => $self->kamailio_port,
    );

    return $sock;
}


## A counter for the RPC request
has _rpc_id => (
    is => 'rwp',
    isa => Int,
    default => 1,
);

has _request_hr => (
    is  => 'rwp',
    isa => HashRef
);
sub _make_request_hr {
    my $self   = shift;
    my $method = shift or die 'No method passed to request';
    my $params = [ @_ ];

    my $args = {
        jsonrpc => $jsonrpc,
        id      => $self->_rpc_id,
        method  => $method,
    };

    if ($params) {
        $args->{params} = $params;
    };
    $self->_set__request_hr($args);
}


sub request {
    my $self = shift;
    my @args = @_;
    $self->_make_request_hr(@_);
}

1;
__END__

=encoding utf-8

=head1 NAME

WHOSGONNA::Kamailio::RPC::UDP - It's new $module

=head1 SYNOPSIS

    use WHOSGONNA::Kamailio::RPC::UDP;

=head1 DESCRIPTION

WHOSGONNA::Kamailio::RPC::UDP is ...

=head1 LICENSE

Copyright (C) Ben Kaufman.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Ben Kaufman E<lt>ben.kaufman@altigen.comE<gt>

=cut

