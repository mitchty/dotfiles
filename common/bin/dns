#!/usr/bin/env perl
#
# Stupid script to help with dns information. Solaris 9/8 lack the host utility.
# Which this (kinda) mimics, except the mx record crap
use strict;
use warnings;
use Socket;
use Sys::Hostname;

my $input = shift || hostname();
my $lookup = $input;

if ( $lookup =~ /\d+[.]\d+[.]\d+[.]\d+/smx ) {
  $lookup = ( gethostbyaddr inet_aton($lookup), AF_INET )[0];
  die "Error: Unable to reverse lookup ip $input.\n" if ( $lookup eq q{} );
}

my $ipv4 = gethostbyname $lookup;

die "Error: $lookup doesn't have any known ip addresses\n"
  if ( !defined $ipv4 );

$ipv4 = inet_ntoa($ipv4);

my ( $short_name, $aliases, $addrtype, $len, @addrs ) = gethostbyname $lookup;

foreach my $ipv4 (@addrs) {
  $ipv4 = inet_ntoa($ipv4);
  print "$lookup is $ipv4\n";
}

print "$lookup is also $short_name\n";
if ( defined $aliases and "$aliases" ne q{} ) {
  print "aliases are ($aliases)\n";
}
exit 0;
