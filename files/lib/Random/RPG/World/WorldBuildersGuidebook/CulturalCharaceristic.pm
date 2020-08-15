package Random::RPG::World::WorldBuildersGuidebook::CulturalCharaceristic;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::SpecialDice qw(percentile);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_cultural_characteristic);

# From the World Builder's Guidebook by Richard Baker (c) TSR.
# Cultural Characteristics (Table 21)

my %cultural_characteristics;
$cultural_characteristics{$_} = 'Aborigial'             for 1..3;
$cultural_characteristics{$_} = 'African'               for 4..9;
$cultural_characteristics{$_} = 'Arabic'                for 10..18;
$cultural_characteristics{$_} = 'Aztec/Incan'           for 19..20;
$cultural_characteristics{$_} = 'Barbarian'             for 21..24;
$cultural_characteristics{$_} = 'Central Asian'         for 25..29;
$cultural_characteristics{$_} = 'Egyptian'              for 30..33;
$cultural_characteristics{$_} = 'European, Renaissance' for 34..44;
$cultural_characteristics{$_} = 'European, Middle Ages' for 45..59;
$cultural_characteristics{$_} = 'European, Dark Ages'   for 60..74;
$cultural_characteristics{$_} = 'Indian'                for 75..78;
$cultural_characteristics{$_} = 'Oriental'              for 79..87;
$cultural_characteristics{$_} = 'Persian'               for 88..89;
$cultural_characteristics{$_} = 'Roman'                 for 90..93;
$cultural_characteristics{$_} = 'Savage'                for 94..96;
$cultural_characteristics{$_} = 'Viking'                for 97..100;

sub random_cultural_characteristic {
  my $percent = percentile;
  return $cultural_characteristics{$percent};
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::World::WorldBuildersGuidebook::CulturalCharacteristic> randomly selects the cultural characteristics of the new society.

=head1 VERSION

This document describes Random::RPG::World::WorldBuildersGuidebook::CulturalCharacteristic version 1.0.

=head1 SYNOPSIS

  use Random::RPG::World::WorldBuildersGuidebook::CulturalCharacteristic qw(random_cultural_characteristic);

=head1 DEPENDENCIES

Random::RPG::World::WorldBuildersGuidebook::CulturalCharacteristic depends on L<Random::SpecialDice> and L<Exporter>.

Random::SpecialDice depends on L<Games::Dice>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;