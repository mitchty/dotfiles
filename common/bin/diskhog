#!/usr/bin/env perl
#
# Find out who is hogging disk space and where.
#
# Argument is the directory to start from. Only calculates size of files.
# Adds the size of files in a directory to the size of the parent directory only.
#
# Defaults to top 10 directories/files.
#
# Override with -n num to list whatever amount of large things you desire.
# Or if you want to abuse the parser, use -1 for all files/directories.
#
# Defaults to pwd for space.
#

use File::Find;
use Getopt::Long;
use Cwd;

my $debug;
my $statbug;
(exists($ENV{"DEBUG"})) ? $debug++ : undef;
my $dir = Cwd::abs_path($ARGV[-1] || Cwd::getcwd());
my %diskhogs = ();
my %inodes = ();
my ($topdev,undef,undef,undef,undef,undef,undef,undef) = lstat($dir);
local $opt_displaynum = 10;

GetOptions( 'n=i',  => \$opt_displaynum,
      );

find(\&sieve, $dir);

#
# For outputing the size of a bunch of bytes in g/m/k depending upon the size
#
sub byte_print {
  my $byte_k = 1_024;
  my $byte_m = $byte_k**2;
  my $byte_g = $byte_k**3;
  my $bytes = pop;
  my $base = $bytes;
  my $suffix = "nil";
  my $out_string = "BUG";
  if($bytes > $byte_g){
    $base = $bytes / $byte_g;
    $suffix = "g";
  }elsif($bytes > $byte_m){
    $base = $bytes / $byte_m;
    $suffix = "m";
  }else{
    $base = $bytes / $byte_k;
    $suffix = "k";
  };
  $out_string = sprintf("%.2f%s", $base, $suffix);
  return $out_string;
};

#
# Dumb function to return if an inode has already been seen.
# So we handle hard links sane(er-ish-ly) in size calculations.
# This has more truthiness(tm).
#
sub seeninode{
  my $what = pop();
  my $ret = 0;
  unless(exists($inodes{$what})){
    $inodes{$what} = 0;
    print "New inode $what added to seen inodes.\n" if $debug;
  }else{
    $inodes{$what}++;
    $ret++;
    print "Found a hardlink for $what.\n" if $debug;
  };
  return $ret;
};

sub sieve {
  my $file = $File::Find::name;
  my $filedir = $File::Find::dir;
  my @statinfo = lstat($file);
  my $dev = $statinfo[0];
  my $inode = $statinfo[1];
  my $size = $statinfo[7];
  my $blocksize = 512; # field 11 is the "preferred" block size, which appears
                       # to not match the actual blocksize of the filesystems
                       # in use. For now every hard drive uses 512bytes/block.
                       # Will revisit this when 4096byte/block hard drives arrive
  my $apparentsize = $statinfo[12] * $blocksize;

  print "$file\@$filedir \<$topdev\>\=\<$dev\>\n" if $debug;
  print "size,apparentsize,blocksize = <$statinfo[7],$apparentsize\,$blocksize\>\n" if $debug;
  #
  # Try to handle sparse files.
  #
  if ($size > $apparentsize) {
    print "Sparse file $file!\n" if $debug;
    $size = $apparentsize;
  };

  $dev = (-l $file) ? 0xdeadbeef : $dev;
  if (($file =~ m/\/proc|\/chroot|udev\/devices/) ||
      ($dev != $topdev) || seeninode($inode)){
    print "Pruned $file.\n" if $debug;
    $File::Find::prune = 1;
    next;
  };
  unless ($dev){
    # Yay, we can't l(stat) files. This version of perl is broken.
    # Snag information from ls, assume it's a file. Thanks Solaris 8, you suck.
    $statbug++;
    warn "Hit empty device statbug while stat()ing file <$file>.\n";
    my $ls = qx(ls -ld $file);
    my @raw = split(/\s+/, $ls);
    $diskhogs{"$file"} = $raw[4];
    $diskhogs{"$filedir"} += $raw[4];
  }elsif (-f){
    if ($debug){
      print "Adding $file size ", &byte_print($size), " to $filedir.\n";
      print "Adding $file size ", &byte_print($size), "\n";
    };
    $diskhogs{"$file"} = $size;
    $diskhogs{"$filedir"} += $size;
  }elsif (-d){
    print "Adding $file size ".&byte_print($size)."\n" if $debug;
    $diskhogs{"$file"} += $size;
  };
  if ($debug) {
    print "$file from $filedir has size ".&byte_print($diskhogs{"$file"})."\n";
  };
};

#
# Reverse sort the keys by size.
#
my @sorted = sort {$diskhogs{$b} <=> $diskhogs{$a}} keys %diskhogs;

splice @sorted, $opt_displaynum if @sorted > $opt_displaynum;

warn "Found one or more instances of the stat() call statbug. This is normally only present on Solaris 8 with stock perl.\n" if $statbug;

foreach (@sorted){
  printf "%-9s%s\n", &byte_print($diskhogs{$_}), $_;
};

if ($debug){
  print "DEBUG INFORMATION:\n";
  foreach (keys %diskhogs){
    printf "%-9s%s\n", &byte_print($diskhogs{$_}), $_;
  };
};
