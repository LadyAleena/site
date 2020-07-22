package Fancy::Join::Grammatical;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(grammatical_join);

# Written with the help of DrForr in #perlcafe on freenode.
sub grammatical_join {
  my $conj = shift(@_) . ' ';
  return $_[0] if @_ <= 1;
  return join( ' '.$conj, @_ ) if @_ == 2;
  my $punc = grep( /,/, @_ ) ? '; ' : ', ';
  push @_, $conj.pop;
  join($punc, @_);
}

=pod

=encoding utf8

=head1 Fancy::Join::Grammatical

B<Fancy::Join::Grammatical> joins a list with a final conjunction.

=head2 Version

This document describes Fancy::Join::Grammatical version 1.0.

=head2 Synopsis

  Use Fancy::Join::Grammatical qw(grammatical_join);

  my @color_array = ('red', 'yellow', 'green', 'cyan', 'blue', 'magenta');
  my $colors = grammatical_join('and', @color_array);
  # red, yellow, green, cyan, blue, and magenta

=head2 Description

C<grammatical_join> can be exported and returns a string of joined array values with commas and a comma with a conjunction between the last two values. It takes two parameters: the conjunction and the array. If any values within the array already have commas, semicolons will be used in place of commas.

=head2 See also

L<Lingua::EN::Inflect> has C<WORDLIST> and L<Lingua::EN::Inflexion> has C<wordlist> which does a little more than C<grammatical_join>.

=head2 Dependency

Fancy::Join::Grammatical depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;