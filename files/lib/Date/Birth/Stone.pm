package Date::Birth::Stone;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
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

=head1 Date::Birth::Stone

B<Date::Birth::Stone> returns the birth stone associated with months.

=head2 Version

This document describes Date::Birth::Stone version 1.0.

=head2 Synopsis

  use Date::Birth::Stone qw(birth_stone);

  my $birth_stone = birth_stone('July');
  # ruby

=head2 Description

C<birth_stone> is exported by default and returns the birth stone associated with the month entered.

=head2 Dependencies

Date::Birth::Stone depends on L<Exporter> and L<String::Util>.

=head2 Author

Lady Aleena

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