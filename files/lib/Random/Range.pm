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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
