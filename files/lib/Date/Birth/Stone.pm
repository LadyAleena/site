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

  my $birth_stone = birth_stone('July');
  # ruby

=head1 DESCRIPTION

C<birth_stone> is exported by default and returns the birth stone associated with the month entered.

=head1 DEPENDENCIES

Date::Birth::Stone depends on L<Exporter> and L<String::Util>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

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