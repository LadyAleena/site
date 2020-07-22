package Fancy::Join::Defined;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(join_defined);

sub join_defined {
  my $joiner = shift @_;
  return join($joiner, grep(defined, @_));
}

=pod

=encoding utf8

=head1 Fancy::Join::Defined

B<Fancy::Join::Defined> joins only defined values in a list.

=head2 Version

This document describes Fancy::Join::Defined version 1.0.

=head2 Synopsis

  my @base_colors = ('red', undef, 'green', undef, 'blue', undef);
  my $colors = join_defined(',', @base_colors);
  # red, green, blue

=head2 Description

C<join_defined> can be exported and returns a string of only defined values from a list. It takes two parameters: the character which will join the list and a reference to the list.

=head2 Dependency

Fancy::Join::Defined depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;