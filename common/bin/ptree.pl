#!/usr/bin/env perl
#
# ptree for linux/darwin/solaris. I got sick of ps and pstree on linux.
# ptree works on solaris fine, but doesn't exist for darwin/linux/etc...
#
# TODO: Allow passing a regexp instead of a pid and passing multiple pids.
#

local $ENV{"PATH"} = '/bin:/usr/bin:/sbin:/usr/sbin';
local $debug = 0;

(exists($ENV{"DEBUG"})) ? $debug = 1 : undef;
($debug) ? local $| = 1 : undef; # disable buffering for STDERR and STDOUT

sub debug_print {
  ($debug) && warn pop;
};

local @cmd = ('/bin/ps');
local $init = 0;
local $start = 1;

if ($^O eq "linux"){
  push(@cmd, 'ajxSw');
  $start = 0;
}elsif ($^O =~ m/darwin|freebsd/){
  push(@cmd, 'Ajwww');
}elsif ($^O eq "solaris"){
  @cmd = ('/usr/ucb/ps');
  if ((-x "/bin/zonename") && !(qx(zonename) eq "global\n")){
    $init = qx(pgrep zsched);
    chomp($init);
    $start = $init;
  };
  push(@cmd, 'laxwww');
}else{
  die "$^O isn't a known os to this script\n";
};

local @ps = qx(@cmd);
($?) ? die $cmd[0]." posix return code $?\n" : undef;

local %proc;
local @trail;

(defined($ARGV[0])) ? $start = $ARGV[0] : undef;

debug_print("Dump of raw line array data:\n");

foreach my $x (@ps){
  my $cmd_index = 9;
  my $ppid = -1;
  my $pid = -1;
  next if ($x =~ m/.*PID.*/);
  my @line = split(m/\s+/,$x);
  splice(@line, 0, 1) unless ($line[0] =~ m/\d+/);
  splice(@line, 0, 1) if ("$line[0]" eq "");

  if ($^O eq "linux"){
    ($ppid,$pid) = @line;
    $cmd_index = 9;
  }elsif ($^O =~ m/darwin|freebsd/){
    ($pid,$ppid) = @line;
    $cmd_index = 8;
  }elsif ($^O eq "solaris"){
    (undef, undef, $pid,$ppid) = @line;
    for($x=$cmd_index; $x < 14; $x++){
      $cmd_index = ($line[$x] =~ m/\d+\:\d+/) ? ($x + 1) : $cmd_index;
    };
  };

  my $command = join(' ', @line[$cmd_index..$#line++]);
  (!defined $proc{$pid}) ? $proc{$pid}->{"children"} = [ ] : undef;
  (!defined $proc{$ppid}) ? $proc{$ppid}->{"children"} = [ ] : undef;
  $proc{$pid}->{"pid"} = $pid;
  $proc{$pid}->{"command"} = $command;
  $proc{$pid}->{"ppid"} = $ppid;
  push(@{$proc{$ppid}->{"children"}},$pid);
  debug_print(join(',', @line[0..($#line-1)])."\n");
};

if ($debug){
  debug_print("Done reading ps output\nDump of Hash\n");
  foreach my $key (sort({$a <=> $b} (keys %proc))){
    $ppid = $proc{$key}->{"ppid"};
    $command = $proc{$key}->{"command"};
    $children = join(',', @{$proc{$key}->{"children"}});
    debug_print("PID<$key> PPID<$ppid> Children<$children> Command<$command>\n");
  };
};

sub intrail{
  my $crumb = pop;
  my $ret = 0;
  map {$ret++ if ($crumb == $_)} @trail;
  return $ret;
};

sub addchildren{
  my $start_node = pop;
  foreach my $child (@{$proc{$start_node}->{"children"}}){
    next if (!defined($child) || ($start_node == $child));
    debug_print("Start ($start_node) Add child $child.\n");
    push(@trail, $child);
    addchildren($child);
  };
};

sub addparents{
  my $start_node = pop;
  my $parent = $proc{$start_node}->{"ppid"};
  return unless (defined($start_node));
  return if (($parent == $start_node) || !(defined($parent))); # At the top of the tree, or in a zone
  debug_print("Start ($start_node) Add parent $parent.\n");
  push(@trail, $parent);
  addparents($parent) if ($parent != $init);
};

sub printnode{
  my $start_node = pop;
  my $indent = pop;
  if (intrail($start_node)){
    my $pid = $proc{$start_node}->{"pid"};
    my $ppid = $proc{$start_node}->{"ppid"};
    my $cmdline = $proc{$start_node}->{"command"};
    my $indentation = '  'x($indent);
    if ($pid == $init){
      my $s = $^O." kernel";
      if ($cmdline ne ''){
        $s = $s." <$cmdline>";
      };
      $cmdline = $s;
    };
    printf("%s%d   %s\n", $indentation, $pid, $cmdline);
    foreach my $child (@{$proc{$start_node}->{"children"}}){
      next if ($pid == $child);
      printnode($indent+1,$child);
    };
  };
};

my $valid = 0;
foreach my $j (keys %proc){ ($j == $start) ? $valid++ : undef; };

debug_print("Starting from <$start>, validity is<$valid>\n");

if ($valid){
  if (!$start){
    @trail = keys %proc;
    push(@trail, $start); push(@trail, 1);
    debug_print("Done with adding $start to trail.\n");
  }else{
    push(@trail, $start);
    debug_print("Adding children from $start.\n");
    addchildren($start);
    debug_print("Adding parents from $start.\n");
    addparents($start);
  };

  @trail = sort(@trail);

  debug_print("Trail is: ".join(',', @trail)."\nStarting at pid $start\ninit pid $init\n");
  print "PID COMMAND\n";
  my $startindent = 0;
  (intrail($startindent)) ? $startindent = -1 : undef;
  printnode($startindent,$init);
}else{
  die "pid $start doesn't exist.\n";
};

exit 0;
