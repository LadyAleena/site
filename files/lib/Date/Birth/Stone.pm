package Date::Birth::Stone;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT = qw(birth_stone);

use String::Util qw(trim);

my $stones;
while (<DATA>) {
  chomp($_);
  my ($month, $stone) = split(/\|/, $_);
  $month = trim($month);

  $stones->{$month} = trim($stone);
}

sub birth_stone {
  my ($month) = @_;
  return $stones->{$month};
}

=head1 NAME

B<Date::Birth::Stone> returns the birth stone associated with months.

=head1 SYNOPSIS

  my $birth_stone = birth_stone('July');
  # ruby

=head1 DESCRIPTION

C<birth_stone> is exported by default and returns the birth stone associated with the month entered.

=head1 AUTHOR

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