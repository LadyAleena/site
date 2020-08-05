package Fun::Refreshment;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(refreshment);

my @refreshments = ('cookies','carrots','chips','crackers','chocolate mousse','soda','wine','coffee');

my @cookies = (
  '', 'sugar', 'shortbread', 'butter', 'gingerbread', 'oatmeal', 'peanut butter', 'fortune', 'chocolate',
  'chocolate chip', 'chocolate chunk', 'chocolate chocolate chip', 'brownie-style', 'brownie-style chocolate chip',
  'raisin', 'oatmeal raisin');

my @chips = ('', 'corn', 'potato');

my @wines = ('', 'red', 'white');

my %containers = (
  'cookies' => 'platter',
  'carrots' => 'tray',
  'chips' => 'bowl',
  'crackers' => 'tray',
  'chocolate mousse' => 'bowl',
  'soda' => 'cooler',
  'wine' => 'carafe',
  'coffee' => 'pot',
);

sub refreshment {
  my $refreshment = $refreshments[rand @refreshments];
  my $container   = $containers{$refreshment};

  if ($refreshment eq 'cookies') {
    my $cookie = $cookies[rand @cookies];
    $refreshment = length($cookie) ? "$cookie $refreshment" : $refreshment;
  }
  elsif ($refreshment eq 'chips') {
    my $chip = $chips[rand @chips];
    $refreshment = length($chip) ? "$chip $refreshment" : $refreshment;
  }
  elsif ($refreshment eq 'wine') {
    my $wine = $wines[rand @wines];
    $refreshment = length($wine) ? "$wine $refreshment" : $refreshment;
  }

  return "$container of $refreshment";
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

=head1 DESCRIPTION

Fun::Refreshment was written for fun and based on my putting cookies out of the sideboard of the Chatterbox on PerlMonks. It returns a random string of what you might want to put out somewhere.

  print refreshment();

Here are the strings that it can output.

  puts out a platter of cookies
  puts out a tray of carrots
  puts out a bowl of chips
  puts out a tray of crackers
  puts out a bowl of chocolate mousse
  puts out a cooler of soda
  puts out a carafe of wine
  puts out a pot of coffee

Cookies, chips, and wine may be prefaced with a more specific type.

=head1 DEPENDENCIES

Fun::Refreshment depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;