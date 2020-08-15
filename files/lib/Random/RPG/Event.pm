package Random::RPG::Event;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(tiny_rand);
use Random::RPG::AbilityScores qw(random_ability);
use Random::RPG::SavingThrow qw(random_saving_throw);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_event);

my @base_events = (
  random_ability.' check',
  'non-weapon proficiency check',
  'saving throw'.tiny_rand('',' vs. '.random_saving_throw(tiny_rand('by keys','all'))),
  'backstab',
  'undead turning',
  'spell memorization'
);

my @game_rolls = (
  random_ability.' checks',
  'on non-weapon proficiency checks',
  'to saving throws'.tiny_rand('',' vs. '.random_saving_throw(tiny_rand('by keys','all'))),
  'Armor Class',
  'THAC0 modifier',
  'to Surprise'
);

my @events;
for my $event (@base_events) {
  push @events, map("$_ $event", qw(successful failed));
}
push @events, map("critical $_", qw(hit miss));

sub random_event {
  return tiny_rand(@events);
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::Event> selects random game events based on I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::Event version 1.000.

=head1 SYNOPSIS

  use Random::RPG::Event qw(random_event);

=head1 DEPENDENCIES

Random::RPG::Event depends on L<Fancy::Rand>, L<Random::RPG::AbilityScores>, L<Random::RPG::SavingThrow>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;