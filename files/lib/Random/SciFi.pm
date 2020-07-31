package Random::SciFi;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Random::Alpha qw(random_alpha);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_HHGTTG_sector random_MIB_agent);

sub random_letters {
  my ($number) = @_;
  my $letter = sub { random_alpha('upper case') };
  my $letters;
  $letters .= &$letter for (1..$number);
  return $letters;
}

sub random_HHGTTG_sector {
  my @types = qw(Active Heavy Light Over Plural Passive Single Under);
  my $Greek = sub { random_alpha('Greek') };
  my $type  = sub { $types[rand @types] };
  return random_letters(2)." ".&$type." ".random_letters(1)." ".&$Greek;
}

sub random_MIB_agent {
  my @letters = (1, 2);
  my $letter  = $letters[rand @letters];
  return random_letters($letter);
}

=pod

=encoding utf8

=head1 NAME

B<Random::SciFi> returns a random I<Hitckhikers Guide to the Galaxy> sector or a random I<Men in Black> agent id.

=head1 VERSION

This document describes Random::SciFi version 1.000.

=head1 SYNOPSIS

  use Random::SciFi qw(random_HHGTTG_sector random_MIB_agent);

  my $random_HHGTTG_sector = random_HHGTTG_sector(); # returns a random sector based on HHTTG sectors mentioned.
  my $random_MIB_agent     = random_MIB_agent();     # returns a random MIB agent, either single or double letter.

=head1 DEPENDENCIES

Random::SciFi depends on L<Random::Alpha> and L<Exporter>.

Random::Alpha depends on L<Fancy::Rand> and L<Util::Data>.

=head1 AUTHOR

Lady Aleena

=cut

1;