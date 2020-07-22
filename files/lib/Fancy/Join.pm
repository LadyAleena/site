package Fancy::Join;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Join::Defined     qw(join_defined);
use Fancy::Join::Grammatical qw(grammatical_join);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(
  join_defined
  grammatical_join
);

=pod

=encoding utf8

=head1 NAME

B<Fancy::Function> is a collection of functions that have been given a bit of additional functionality.

=head1 VERSION

This document describes Fancy::Join version 1.0.

=head1 SYNOPSIS

  use Fancy::Join qw(join_defined grammatical_join);

=head2 join_defined

  my @base_colors = ('red', undef, 'green', undef, 'blue', undef);
  my $colors = join_defined(',', @base_colors);
  # red, green, blue

=head2 grammtical_join

  my @color_array = ('red', 'yellow', 'green', 'cyan', 'blue', 'magenta');
  my $colors = grammatical_join('and', @color_array);
  # red, yellow, green, cyan, blue, and magenta

=head1 DESCRIPTION

=head2 join_defined

C<join_defined> can be exported and returns a string of only defined values from a list. It takes two parameters: the character which will join the list and a reference to the list.

You can use C<join_defined> here or from L<Fancy::Join> or L<Fancy::Join::Defined>.

=head2 grammatical_join

C<grammatical_join> can be exported and returns a string of joined array values with commas and a comma with a conjunction between the last two values. It takes two parameters: the conjunction and the array. If any values within the array already have commas, semicolons will be used in place of commas.

You can use C<grammatical_join> here or from L<Fancy::Join> or L<Fancy::Join::Grammatical>.

=head3 Note

L<Lingua::EN::Inflect> has C<WORDLIST> and L<Lingua::EN::Inflexion> has C<wordlist> which does a little more than C<grammatical_join>.

=head1 DEPENDENCIES

Fancy::Join depends on L<Exporter>, L<Fancy::Join::Defined>, and L<Fancy::Join::Grammatical>.

=head1 AUTHOR

Lady Aleena

=cut

1;