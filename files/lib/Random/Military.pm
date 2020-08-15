package Random::Military;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(random_military random_military_by_location);

# Get the rank of the leader of the unit.
sub rank {
  my $unit = shift;

  my %ranks = (
    'squad'     => 'corporal',
    'platoon'   => 'sergeant',
    'company'   => 'lieutenant',
    'battalion' => 'captain',
    'regiment'  => 'major',
    'brigade'   => 'colonel',
    'division'  => 'general',
    'army'      => 'king',
  );

  return $ranks{$unit};
}

sub unit {
  my ($unit_type, $subunits) = @_;

  my $unit_leader = rank($unit_type);

  my $totals;
  $totals->{$unit_leader} = 1;
  for my $subunit (@$subunits) {
    my $unit_totals = $subunit->{totals};
    $totals->{$_} += $unit_totals->{$_} for keys %$unit_totals;
  }
  $totals->{total}++;

  return { 'unit' => $subunits, 'unit type' => $unit_type, 'unit leader' => $unit_leader, totals => $totals }
}

sub squad {
  my $roll = roll('2d4');
  my $unit_type = 'squad';
  my $unit_leader = rank($unit_type);

  my $totals;
  $totals->{$unit_leader} = 1;
  $totals->{soldiers} = $roll;
  $totals->{total}    = $roll + 1;

  return { 'soldiers' => $roll, 'unit type' => $unit_type, 'unit leader' => $unit_leader, 'totals' => $totals };
}

sub platoon {
  my $roll = roll('2d3');
  my @subunits = map { squad() } (1..$roll);
  my $unit = unit('platoon', \@subunits);
  return $unit;
}

sub company {
  my $roll = roll('2d2');
  my @subunits = map { platoon() } (1..$roll);
  my $unit = unit('company', \@subunits);
  return $unit;
}

sub battalion {
  my $roll = roll('2d2');
  my @subunits = map { company() } (1..$roll);
  my $unit = unit('battalion', \@subunits);
  return $unit;
}

sub regiment {
  my $roll = roll('2d2');
  my @subunits = map { battalion() } (1..$roll);
  my $unit = unit('regiment', \@subunits);
  return $unit;
}

sub brigade {
  my $roll = roll('2d2');
  my @subunits = map { regiment() } (1..$roll);
  my $unit = unit('brigade', \@subunits);
  return $unit;
}

sub division {
  my $roll = roll('2d2');
  my @subunits = map { brigade() } (1..$roll);
  my $unit = unit('division', \@subunits);
  return $unit;
}

sub army {
  my $roll = roll('2d2');
  my @subunits = map { division() } (1..$roll);
  my $unit = unit('army', \@subunits);
  return $unit;
}

# Get the unit.
sub random_military {
  my $group = shift;
  my %groups = (
    'squad'     => sub { &squad },
    'platoon'   => sub { &platoon },
    'company'   => sub { &company },
    'battalion' => sub { &battalion },
    'regiment'  => sub { &regiment },
    'brigade'   => sub { &brigade },
    'division'  => sub { &division },
    'army'      => sub { &army },
  );

  return &{$groups{$group}};
}

sub random_military_by_location {
  my $land_type = shift;

  my %lands = (
    'village'     => 'squad',
    'small town'  => 'platoon',
    'large town'  => 'company',
    'barony'      => 'battalion',
    'county'      => 'regiment',
    'duchy'       => 'brigade',
    'grand duchy' => 'division',
    'kingdom'     => 'army',
  );

  my $unit = $lands{$land_type};
  return random_military($unit);
}

=pod

=encoding utf8

=head1 NAME

B<Random::Military> returns a fictional and fantasy military unit.

=head1 VERSION

This document describes Random::Military version 1.0.

=head1 SYNOPSIS

  use Random::Military qw(random_military random_military_by_location);

  my $squad      = random_military('squad');
  my $platoon    = random_military('platoon');
  my $company    = random_military('company');
  my $battallion = random_military('batallion');
  my $regiment   = random_military('regiment');
  my $brigade    = random_military('brigade');
  my $division   = random_military('division');
  my $army       = random_military('army');

  my $village_military     = random_military_by_location('village');
  my $small_town_military  = random_military_by_location('small town');
  my $large_town_military  = random_military_by_location('large town');
  my $barony_military      = random_military_by_location('barony');
  my $county_military      = random_military_by_location('county');
  my $duchy_military       = random_military_by_location('duchy');
  my $grand_duchy_military = random_military_by_location('grand duchy');
  my $kingdom_military     = random_military_by_location('kingdom');

=head1 DESCRIPTION

The functions of Random::Military will return a hash with the statistics of the selected military unit. The larger the military, the larger and deeper the hash will be. C<random_military> and C<random_military_by_location> must be imported into your script.

The hash for each unit and any subunits will include the leader of the unit, the amount of each subordinate type, and the total amount of soldiers in the unit. To see the full unit, use your favorite data dumping module.

=head2 random_military

  random_military('<your option>');

=head3 Options

=head4 squad

  random_military('squad');

The C<squad> option returns a unit of 2 to 8 soldiers with a corporal as the leader.

=head4 platoon

  random_military('platoon');

The C<platoon> option returns a unit of 2 to 6 squads with a sergeant as the leader.

=head4 company

  random_military('company');

The C<company> option returns a unit of 2 to 4 platoons with a lieutenant as the leader.

=head4 batallion

  random_military('batallion');

The C<batallion> option returns a unit of 2 to 4 companies with a captain as the leader.

=head4 regiment

  random_military('regiment');

The C<regiment> option returns a unit of 2 to 4 batallions with a major as the leader.

=head4 brigade

  random_military('brigade');

The C<brigade> option returns a unit of 2 to 4 regiments with a colonel as the leader.

=head4 division

  random_military('division');

The C<division> option returns a unit of 2 to 4 brigades with a general as the leader.

=head4 army

  random_military('army');

The C<army> option returns a unit of 2 to 4 divisions with a king as the leader.

=head3 Samples

The following samples are provided so you can see what data will be returned to you. The data will get deeper as you generate larger miliary units.

=head4 squad sample

  {
    "unit type"   => "squad",
    "unit leader" => "corporal",
    "soldiers"    => 4,
    "totals"      => { corporal => 1, soldiers => 4, total => 5 },
  }

=head4 platoon sample

  {
    "unit type"   => "platoon",
    "unit leader" => "sergeant",
    "unit"        => [
                       {
                         "unit type"   => "squad",
                         "unit leader" => "corporal",
                         "soldiers"    => 3,
                         "totals"      => { corporal => 1, soldiers => 3, total => 4 },
                       },
                       {
                         "unit type"   => "squad",
                         "unit leader" => "corporal",
                         "soldiers"    => 6,
                         "totals"      => { corporal => 1, soldiers => 6, total => 7 },
                       },
                       {
                         "unit type"   => "squad",
                         "unit leader" => "corporal",
                         "soldiers"    => 5,
                         "totals"      => { corporal => 1, soldiers => 5, total => 6 },
                       },
                       {
                         "unit type"   => "squad",
                         "unit leader" => "corporal",
                         "soldiers"    => 4,
                         "totals"      => { corporal => 1, soldiers => 4, total => 5 },
                       },
                       {
                         "unit type"   => "squad",
                         "unit leader" => "corporal",
                         "soldiers"    => 7,
                         "totals"      => { corporal => 1, soldiers => 7, total => 8 },
                       },
                     ],
    "totals"      => { sergeant => 1, corporal => 5, soldiers => 25, total => 31 },
  }

=head4 army totals sample

  {
    "totals" => {
                  soldiers   => 18021,
                  corporal   => 3591,
                  sergeant   => 898,
                  lieutenant => 295,
                  captain    => 95,
                  major      => 32,
                  colonel    => 10,
                  general    => 3,
                  king       => 1,
                  total      => 22946,
                },
  }

=head2 random_military_by_location

  random_military_by_location('<your option>');

C<random_military_by_location> was written for fun even though it mimics C<random_military>.

=head3 Options

=head4 village

  random_military_by_location('village');

The C<village> option returns a squad.

=head4 small town

  random_military_by_location('small town');

The C<small town> option returns a platoon.

=head4 large town

  random_military_by_location('large town');

The C<large town> option returns a company.

=head4 barony

  random_military_by_location('barony');

The C<barony> option returns a battalion.

=head4 county

  random_military_by_location('county');

The C<county> option returns a regiment.

=head4 duchy

  random_military_by_location('duchy');

The C<duchy> option returns a brigade.

=head4 grand duchy

  random_military_by_location('grand duchy');

The C<grand duchy> option returns a division.

=head4 kingdom

  random_military_by_location('kingdom');

The C<kingdom> option returns an army.

=head1 DEPENDENCIES

Random::Military depends on L<Games::Dice> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;