package Random::RPG::Class;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand tiny_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_class random_class_special);

my %classes = (
  'warrior'    => ['fighter', 'paladin', 'ranger'],
  'rogue'      => ['thief', 'bard'],
  'priest'     => ['cleric', 'priest', 'druid', 'shaman'],
  'wizard'     => ['mage', 'wizard'],
  'psionisist' => ['psionisist'],
);

my %class_specials_info = (
  'warrior' => 'attacks',
  'thief'   => 'backstabs',
  'priest'  => 'turns undead',
  'wizard'  => 'creates magic items'
);

my @class_specials = (map(
  "$class_specials_info{$_} as a $_ of the same level. If already a $_, $class_specials_info{$_} at 1 level higher.",
  keys %class_specials_info
));

sub random_class {
  my ($user_class, $user_additions) = @_;
  my $class = fancy_rand(\%classes, $user_class, { caller => 'random_class', additions => $user_additions ? $user_additions : undef });
  return $class;
}

sub random_class_special {
  return tiny_rand(@class_specials);
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::Classes> selects random adventurer classes from I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::Class version 1.000.

=head1 SYNOPSIS

  use Random::RPG::Class qw(random_class random_class_special);

=head1 DEPENDENCIES

Random::RPG::Class depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;