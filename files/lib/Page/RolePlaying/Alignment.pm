package Page::RolePlaying::Alignment;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(expand_alignment alignment_class);

use Page::Convert qw(idify);

sub expand_alignment {
  my ($var) = @_;
  $var = uc $var;
  $var =~ s/^(-\w|\+\w|\w\(\w\)|\w)(-\w|\+\w|\w\(\w\)|\w)$/$1 and $2/;
  $var =~ s/\((\w)\)/ with $1 tendencies/g;
  $var =~ s/\+(\w)/true $1/g;
  $var =~ s/-/non-/g;
  $var =~ s/T N/true neutral/;
  $var =~ s/N/neutral/g;
  $var =~ s/L/lawful/;
  $var =~ s/C/chaotic/;
  $var =~ s/G/good/;
  $var =~ s/E/evil/;
  $var =~ s/^(\w+) and (\w+)$/$1 $2/;
  return $var;
}

sub alignment_class {
  my ($var) = shift;
  my $class = idify(expand_alignment($var));
     $class =~ s/-/_/;
     $class =~ s/_tendencies//;
     $class =~ s/with/w/;
  return $class;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;