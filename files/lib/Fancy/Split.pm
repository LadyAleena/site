package Fancy::Split;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_split);

# written with help, but I'm embarrassed I didn't note them.
sub fancy_split {
  my ($character, $string, $number) = @_;

  my @split_array = split(/$character/, $string);

  my $rejoined;
  for (my $i = 0; $i < @split_array; $i += $number) {
    my $max = $i + $number - 1 > $#split_array ? $#split_array : $i + $number - 1;
    push @{$rejoined}, join($character, @split_array[$i..$max])
  }

  return $rejoined;
}

=pod

=encoding utf8

=head1 NAME

B<Fancy::Split> splits a string into groups.

=head1 SYNOPSIS

  my $string = "red, orange, yellow, spring, green, teal, cyan, azure,
                blue, violet, magenta, pink, white, black, gray";
  my @array = fancy_split(', ', $string, 2);

  [
    'red, orange',
    'yellow, spring',
    'green, teal',
    'cyan, azure',
    'blue, violet',
    'magenta, pink',
    'white, black',
    'gray'
  ];

=head1 DESCRIPTION

C<fancy_split> can be exported and returns a referenced array split by a user specified amount. It takes two paraments: the size of the groups and the string to be split. The size can be any integer.

=head1 DEPENDENCY

Fancy::Split depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;