#!/usr/bin/env perl
#
# Convert input ip/cidr|netmask|hexnetmask to useable network information.
#

use strict;
use warnings;
use Socket;
use Sys::Hostname;

#
# Globalish vars
#
$ENV{PATH} = '/usr/bin:/bin:/usr/sbin:/sbin'; # Paranoia, know thy name!
my ($fqdn_regexp) = qr/([0-9,a-z,A-Z,\-,\_]+)\.([0-9,a-z,A-Z,\-,\_]+)\.(com|gov)/;

#
# converts a 1-word (4 byte) signed or unsigned integer into a dotted decimal
# ip address.
#
sub int2ip {
  my $n=int(pop);
  return(sprintf("%d.%d.%d.%d", ($n>>24)&0xff,($n>>16)&0xff,
    ($n>>8)&0xff,$n&0xff));
};

#
# Convert a host/ip/netmask/cidr/etc.... to a hash of information
# Example: host.domain.tld/24 will get the ip and calculate the netmask info
#  equally if host.domain.tld corresponds with 1.2.3.4 the following is valid
#  1.2.3.4/255.255.255.0 would obtain the same information.
#
# die()'s if anything isn't kosher.
#
# Ultra long function, probably needs to be looked at for condensing/splitting.
#
sub cidr2raw {
  my $rawinput = pop;
  my ($lhs, $rhs, $j, $uip) = (undef, undef, undef, undef);
  my ($ucidr) = 0;
  my ($network, $bits, $netmask, $broadcast, $low, $high);

  if ($rawinput =~ qr/(.*)\/(.*)/){
      $lhs = $1; $rhs = $2;
  }else{
    die "Input: $rawinput not expected.\n";
  };

  #
  # Handle ip/hostname for left hand side.
  if ($lhs =~ qr/(\d+)\.(\d+)\.(\d+)\.(\d+)/){
    foreach my $dotted (($1,$2,$3,$4)){
      if (($dotted > 255) or ($dotted < 0)){
        die "FATAL: ipv4 address entered, $lhs entered is impossible, $dotted is not between 0-255.\n";
      };
    };
    $uip = inet_ntoa(scalar gethostbyname($lhs));
    die "FATAL: Cannot determine hostname for $lhs$!\n" if (!defined($lhs));
  }elsif ($lhs =~ $fqdn_regexp){
    my $tmp = gethostbyname($lhs);
    die "FATAL: Cannot determine ip for $lhs" if (!defined($tmp));
    $uip = inet_ntoa($tmp);
  }else{
    die "FATAL: host value not fully qualified, or not an ip <$lhs>\n";
  };

  #
  # Handle the netmask/cidr for the right hand side,
  #
  # All input netmasks are converted to a cidr address for notation
  if ($rhs =~ qr/^(\d+)$/){ # /cidr
    $ucidr = $1;
    die "FATAL: Invalid CIDR <$ucidr>.$!\n" if (($ucidr > 32) or ($ucidr < 0));
  }elsif ($rhs =~ qr/(0[xX])?([0-9,a-f,A-F]{7})/){ # /0xhexnetmask
    my $trimmed = $2;
    my $insane = 0;
    foreach my $byte (split('', unpack("B32", pack("H*", $trimmed)))){
      ($byte) ? $ucidr++ : $insane++;
      die "FATAL: $rhs is not a valid hex netmask.$!\n" if ($insane and $byte);
    };
  }elsif ($rhs =~ qr/(\d+)\.(\d+)\.(\d+)\.(\d+)/){ # /255.255.255.0 form
    my @a = ($1, $2, $3, $4);
    my $insane = 0;
    foreach my $t (@a){
      die "FATAL: Netmask out of range. Input <$rhs> Invalid <$t>$!\n" if (($t < 0) or ($t > 255));
    };
    foreach my $byte (split('', unpack("B32", pack("C4", @a)))){
      ($byte) ? $ucidr++ : $insane++;
      die "FATAL: $rhs is not a valid netmask.$!\n" if ($insane and $byte);
    };
  }else{
    die "FATAL: Unknown or invalid netmask value entered. <$rhs>\n";
  };

  #
  # Network math GO! This is the meat of the function.
  my (@uip) = split(/\./, $uip);
  $network = 0;
  for ($j = 0; $j <= $#uip; $j++){
    $network += int($uip[$j])<<((3-$j)*8);
  };

  $bits = 0; $j = 0;
  for ($j = 31 - $ucidr; $j >= 0; $j--){
    $bits |= 1<<$j;
  };

  $netmask = 0xffffffff^$bits;
  $low = ($network&$netmask);
  $high = ($network&$netmask)+$bits-1;
  $broadcast = ($network&$netmask)|$bits;
  my ($guessed_hostname,undef,undef,undef,undef) = gethostbyaddr(inet_aton($uip), AF_INET);

  #
  # Throw the info back, they get a hash with zie info they may/may not need.
  # All up to the caller what they want to use.
  #
  return ("inet4" => $uip,
          "netmask" => int2ip($netmask),
          "broadcast" => int2ip($broadcast),
          "cidr" => $ucidr,
          "router" => int2ip($low+1),
          "network" => int2ip($low),
          "high" => int2ip($high),
          "hostname" => $guessed_hostname,
          );
};

#package Main; # future use

foreach my $arg (@ARGV){
  my %stuff = cidr2raw($arg);
  printf("%s/%s is %s/%s\n%-12s\t%s\n%-12s\t%s\n%-12s\t%s\n%-12s\t%s\n%-12s\t%s\n",
             $stuff{"inet4"},$stuff{"cidr"},
             $stuff{"network"},$stuff{"cidr"},
             "Netmask",$stuff{"netmask"},
             "Broadcast",$stuff{"broadcast"},
             "Network",$stuff{"network"},
             "Router",$stuff{"router"},
             "HighUsable",$stuff{"high"},
      );
};
