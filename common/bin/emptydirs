#!/usr/bin/env perl
#
# Because all find implementations, that is, everything but gnu find.
# lack -find as an option.
#

use File::Find;

my $debug;
(exists($ENV{"DEBUG"})) ? $debug++ : undef;
my $dir = $ARGV[-1] || '/tmp';


find(\&sieve, $dir);

sub sieve {
  my $file = $File::Find::name;
  my $filedir = $File::Find::dir;
  my ($dev,$inode,undef,undef,undef,undef,undef,$size) = lstat($file);
  next if !(-d $file); # Only zie diectories BITTE!
  #
  # Ok, lets see if readdir returns more than 2 entries.
  opendir my $H, $file or next;
  print "$file\n" unless (grep !/^\.{1,2}/, readdir $H);
  close $H;
};
