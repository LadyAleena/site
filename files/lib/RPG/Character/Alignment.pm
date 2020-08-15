package RPG::Character::Alignment;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(expand_alignment alignment_class);

use Util::Convert qw(idify);

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

=pod

=encoding utf8

=head1 NAME

B<RPG::Character::Alignment> expands alignments for AD&D 2nd Edition.

=head1 SYNOPSIS

To use this module to expand alignment abbreviations from their two character forms.

  use RPG::Character::Alignment qw(expand_alignment);

Samples...

  expand_alignment('CG')                # returns "chaotic good".
  expand_alignment('LE')                # returns "lawful evil".

There is no default for expand_alignment.

=head1 SEE ALSO

You can generate random alignments with B<L<Random::RPG::Alignment>>.

=head1 AUTHOR

Lady Aleena with lots of help from DrForr, whoppix, and rindolf in the #perlcafe on freenode.

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;