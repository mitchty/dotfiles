#!/usr/bin/env perl
#
# Because i'm lazy and sick of typing in getent passwd $someusername/uid
#

my %who_cmds = ("solaris", "/bin/who -q",
                "linux", "/usr/bin/who -q",
                "darwin", "/usr/bin/who -q",
               );

my $who_cmd = $who_cmds{$^O};

local %users = ();

foreach my $l (qx/$who_cmd/){
  next if($l =~ m/^\#.*/);
  foreach my $user (split(/\s+/,$l)){
    unless(exists($users{$user})){
      $users{$user} = 0;
    }else{
      $users{$user}++;
    };
  };
};

foreach my $user (keys %users){
  my $gecos = ( getpwnam($user) )[6];
  my $count = $users{$user} + 1;
  my $output = "$user\, ".((defined($gecos)) ? "$gecos, " : '')."is logged in on $count tty".(($count>1) ? "\'s" : '')."\n";
  print $output;
};
