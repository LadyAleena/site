package Fun::Refreshment;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(A);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(refreshment);

my @refreshments = ('cookies','carrots','chips','chocolate mousse','soda','wine','coffee');
my %containers = (
  'cookies' => 'platter',
  'carrots' => 'tray',
  'chips' => 'bowl',
  'chocolate mousse' => 'bowl',
  'soda' => 'cooler',
  'wine' => 'carafe',
  'coffee' => 'pot',
);

sub refreshment {
  my @table = map(A($containers{$_})." of ".$_, @refreshments);
  return "puts out ".$table[rand @table];
}

=pod

=encoding utf8

=head1 NAME

B<Fun::Refreshment> returns a random refreshment for you to put out on a surface.

=head1 VERSION

This document describes Fun::Refreshment version 1.0.

=head1 SYNOPSIS

  use Fun::Refreshment qw(refreshment);

  my $refreshment_offering = refreshment();

=head1 DEPENDENCIES

Fun::Refreshment depends on L<Exporter> and L<Lingua::EN::Inflect>.

=head1 AUTHOR

Lady Aleena

=cut

1;