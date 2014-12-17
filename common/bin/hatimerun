#!/usr/bin/env perl
#
# hatimerun in perl, sorta
#
use Getopt::Long;

my $opt_exitcode = 99;
my $opt_killcode = 9;
my $opt_timeout = 60;

GetOptions( 'e=i' => \$opt_exitcode,
            'k=i' => \$opt_killcode,
            't=i' => \$opt_timeout,
            'h' => \&opt_help,
            'help' => \&opt_help,
);

sub opt_help{
  my $message = <<__END__;
UX: ERROR: invalid syntax
usage: [-e return code][-k kill signal][-t seconds to wait]
       [-h][--help]

  Options
      --help, -h     Prints this help text.
      -e             Exit code to return on timeout.
                     NOTE: 99 by default.
      -k             Signal number to send via kill.
                     NOTE: 9 by default.
      -t             Timeout in seconds before alarming.
                     NOTE: 60 by default.

__END__
  print $message;
  exit 1;
};

my $pid;

local $SIG{ALRM} = sub { kill $opt_killcode, $pid or die "Kill failed: $!";
                         die "Timeout!\n"};

eval{
  my $x = defined($pid = fork());

  unless ($pid){
    print qx(@ARGV);
    die "Exec of ", join(' ', @ARGV), " failed at $!\n";
  };

  alarm $opt_timeout;
  waitpid $pid => 0;
  alarm 0;
  exit 0;
};

if ($@){
  die "Nothing to do!\n" unless $@ eq "Timeout!\n";
  exit $opt_exitcode;
}else{
  exit 0;
};
