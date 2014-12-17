#!/usr/bin/env perl
#
# Just opens a socket and tries to connect() to it. rc = 1 on failure, 0 success
#
use Socket;

local $where = $ARGV[0];
local $port = $ARGV[1];

socket(SOCKET,PF_INET,SOCK_STREAM,(getprotobyname("tcp"))[2]);

if(connect(SOCKET,sockaddr_in($port,inet_aton($where)))){
  print "connect($where, $port) succeeded\n";
  exit 0;
}else{
  print "connect($where, $port) failed\n";
  exit 1;
};
