#-*-mode: Perl; coding: utf-8;-*-
package MyModule;

use strict;
use Exporter;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);

$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();
@EXPORT_OK   = qw(func1 func2);
%EXPORT_TAGS = ( DEFAULT => [qw(&func1)],
                 Both    => [qw(&func1 &func2)]);

sub func1  { return reverse @_  }
sub func2  { return map{ uc }@_ }

1;
