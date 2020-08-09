package RPG::Character::WizardSkills;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw();

sub wizard_specialty_powers {
  my ($specialty) = @_;
  my @powers = (
    "+2 to save vs. $specialty spells",
    "-2 to opponents' saves vs. $specialty spells",
    "Cast 1 $specialty spell as if 1d4 levels higher a day",
    "Memorize 1 extra $specialty spell"
  );
  return \@powers;
}

sub wizard_magic_item_creation {
  my ($class, $level) = @_;
  my @creations;
  push @creations, 'scrolls' if ( $class eq 'wizard' && $level >= 9 || $class eq 'priest' && $level >= 7 );
  push @creations, 'potions' if ( $level >= 9 );
  push @creations, 'other magic items', if ( $level >= 11 );

  return \@creations;
}

# unfinished

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;