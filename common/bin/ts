#!/usr/bin/env perl
#
# Timestamp stdin and then print to stdout and flush.
#
# Thats about it. Might add a quick and dirty option to allow you to 
# specify the time output whatnot. But this is intended to be simple.
#

while(<STDIN>){
  print localtime()." : ".$_;
  $stdout.flush;
};
