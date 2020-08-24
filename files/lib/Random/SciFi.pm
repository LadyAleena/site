package Random::SciFi;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Games::Dice qw(roll);
use Lingua::EN::Inflect qw(NUMWORDS);

use Random::Alpha qw(random_alpha);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_HHGTTG_sector random_MIB_agent random_Borg);

sub random_letters {
  my ($number) = @_;
  my $letter = sub { random_alpha('upper case') };
  my $letters;
  $letters .= &$letter for (1..$number);
  return $letters;
}

sub random_HHGTTG_sector {
  my @types = qw(Active Heavy Light Over Plural Passive Single Under);
  my $Greek = sub { random_alpha('Greek named') };
  my $type  = sub { $types[rand @types] };
  return random_letters(2)." ".&$type." ".random_letters(1)." ".&$Greek;
}

sub random_MIB_agent {
  my @letters = (1, 2);
  my $letter  = $letters[rand @letters];
  return random_letters($letter);
}

sub random_Borg {
  my $group_size = roll('1d12');
  my $borg_roll  = roll("1d$group_size");
  my $unimatrix  = sprintf("%02d", roll("1d100"));

  my @numbers = map { ucfirst NUMWORDS($_) } ($borg_roll, $group_size);

  my $borg = join(' of ', @numbers)." of Unimatrix $unimatrix";
  return $borg;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
