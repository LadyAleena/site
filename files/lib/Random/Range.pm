package Random::Range;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_range_unit random_range random_radius);

my %range_units = (
  'imperial' => [qw(in ft yd mi)],
  'metric'   => [qw(cm dm m km)],
);

sub random_range_unit {
  my ($user_unit, $user_additions) = @_;
  my $unit = fancy_rand(\%range_units, $user_unit, { caller => 'random_range_unit', additions => $user_additions ? $user_additions : undef });
  return $unit;
}

sub random_range {
  my ($unit, $list) = @_;

  my @ranges = (1,5,10,20,50,100);
  push @ranges, 'touch' if ($list && $list eq 'touch');

  my $range = $ranges[rand @ranges];

  my $full_range;
  if ($range eq 'touch') {
    $full_range = $range;
  }
  else {
    my $measure = !$unit              ? random_range_unit :
                  $range_units{$unit} ? random_range_unit($unit) :
                  $unit;
    $full_range = join(' ',($range, $measure))
  }

  return $full_range;
}

sub random_radius {
  my ($unit, $list) = @_;
  my $radius = random_range($unit, $list);

  my $full_radius = $radius eq 'touch' ? "by $radius" : "in a $radius radius";
  return $full_radius;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Range> returns a random range or radius.

=head1 VERSION

This document describes Random::Range version 1.000.

=head1 SYNOPSIS

  use Random::Range qw(random_range_unit random_range random_radius);

  my $range_unit          = random_range_unit;
  my $imperial_range_unit = random_range_unit('imperial');
  my $metric_range_unit   = random_range_unit('metric');

  print random_range_unit('help') # get random_range_unit options

  random_range();
  random_range('imperial')    # returns 1, 5, 10, 20, 50, or 100 in, ft, yd, or mi.
  random_range('metric')      # returns 1, 5, 10, 20, 50, or 100 cm, dm, m, or km.
  random_range('your choice') # returns 1, 5, 10, 20, 50, or 100 and your measurement choice.
  random_range('imperial',    'touch')  # returns 1, 5, 10, 20, 50, or 100 in, ft, yd, or mi or touch.
  random_range('metric',      'touch')  # returns 1, 5, 10, 20, 50, or 100 cm, dm, m, or km or touch.
  random_range('your choice', 'touch')  # returns 1, 5, 10, 20, 50, or 100 and your measurement choice or touch.


=head1 DESCRIPTION

Random::Range returns a random unit of length, range, or radius.

=head2 random_range_unit

C<random_range_unit> returns a random unit of measure from a centimeter to a mile. It has two optional parameters: the list option and any units of measure you want to add to the list.

=head3 Options

=head4 nothing, all, or undef

  random_range_unit;
  random_range_unit();
  random_range_unit('all');
  random_range_unit(undef);

These options return any value in any list. You can read the options below to see all of the potential values.

=head4 imperial

  random_range_unit('imperial');

The C<imperial> option returns in, ft, yd, or mi.

=head4 metic

  random_range_unit('metric');

The C<metric> option returns cm, dm, m, or km.

=head4 by keys

  random_range_unit('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_range_unit('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_range_unit('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_range_unit('help');
  random_range_unit('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('range unit 1', 'range unit 2');
  random_range_unit('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 random_range

C<random_range> returns a random range from 1 cm to 100 miles. It has two optional parameters. The first parameter is the units of measure you would like: imperial or metric. The second paramter is to add touch to the list of distances.

=head3 distances

The distances returned can be 1, 5, 10, 20, 50, or 100. You can add touch to the list if the second parameter is C<touch>.

=head2 random_radius

C<random_radius> returns a random radius and has the same optional paramers as C<random_range>. The difference between C<random_radius> and C<random_range> is the string output. C<random_range> only returns the distance, C<random_radius> returns a string like the following:

  by touch
  in a 1 cm radius
  in a 5 in radius
  in a 10 cm radius
  in a 20 m radius
  in a 50 yd radius
  in a 100 dm radius

=head1 DEPENDENCIES

Random::Range depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;