use strict;
use Test::Most;
use WHOSGONNA::Kamailio::RPC::UDP;

my $rpc = WHOSGONNA::Kamailio::RPC::UDP->new();

my $req_hr = {
    'method' => 'mod.stats',
    'jsonrpc' => '2.0',
    'id' => 1,
    'params' => [
        'all',
        'shm'
    ]
}; 

my $resp = $rpc->request(qw(mod.stats all shm));


is_deeply(
    $rpc->_request_hr,
    $req_hr,
    'Request hashref build correctly'
);

#use Data::Printer;
#p $resp;


done_testing;

