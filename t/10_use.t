use strict;
use Test::Most;
use WHOSGONNA::Kamailio::RPC::UDP;



my $no_args = new_ok( 
    'WHOSGONNA::Kamailio::RPC::UDP',
    undef,
   'Instantiation with no arguments'
);

is(
    $no_args->kamailio_peer,
    'localhost',
    "Undefined kamailio_peer is 'localhost'",
);

isa_ok(
    $no_args->_sock,
    'IO::Socket::INET',
    '_sock'
);

is(
    $no_args->_rpc_id,
    1,
    "RPC ID correctly instantiates at '1'"
);


done_testing;

