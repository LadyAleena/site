package Date::Birth::Stone;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use String::Util qw(trim);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(birth_stone);

my $stones;
while (my $line = <DATA>) {
  chomp($line);
  my ($month, $stone) = split(/\|/, $line);
  $month = trim($month);

  $stones->{$month} = trim($stone);
}

sub birth_stone {
  my ($month) = @_;
  return $stones->{$month};
}

=pod

=encoding utf8

=head1 NAME

B<Date::Birth::Stone> returns the birth stone associated with months.

=head1 VERSION

This document describes Date::Birth::Stone version 1.0.

=head1 SYNOPSIS

  use Date::Birth::Stone qw(birth_stone);

  my $birth_stone = birth_stone('July');
  # ruby

=head1 DESCRIPTION

Date::Birth::Stone returns the birth stone associated with months when you use C<birth_stone>. C<birth_stone> needs to be imported into your script. It returns the birth stone associated with the month entered.

Date::Birth::Stone requires Perl version 5.10.0 or better to run.

=head2 The stones

  Month     | Stone
  ----------|----------
  January   | garnet
  February  | amethyst
  March     | aquamarine
  April     | diamond
  May       | emerald
  June      | pearl
  July      | ruby
  August    | peridot
  September | sapphire
  October   | opal
  November  | topaz
  December  | turquoise

=head1 USAGE

C<birth_stone> has only one required parameter, the full name of the month in English.

  birth_stone($month);

=head1 DEPENDENCIES

Date::Birth::Stone depends on L<String::Util> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;

__DATA__
January  |garnet
February |amethyst
March    |aquamarine
April    |diamond
May      |emerald
June     |pearl
July     |ruby
August   |peridot
September|sapphire
October  |opal
November |topaz
December |turquoise