package Fun::AstroBody;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(astro_body);

sub astro_body {
  my @astronomical_body = qw(world sun moon star comet);
  my %astronomical_adjectives = (
    star => ['', qw(falling twinkling)],
    moon => ['', qw(full cresent new harvest blue)],
  );

  my $a_body = $astronomical_body[rand @astronomical_body];

  if ($astronomical_adjectives{$a_body}) {
    my $a_adj = ${$astronomical_adjectives{$a_body}}[rand @{$astronomical_adjectives{$a_body}}];
    return length $a_adj ? "$a_adj $a_body" : $a_body;
  }
  else {
    return $a_body;
  }
}
=pod

=encoding utf8

=head1 Fun::AstroBody

B<Fun::AstroBody> returns a random astronomical body to use instead of "World" in "Hello World!".

=head2 Version

This document describes Fun::AstroBody version 1.0.

=head2 Synopsis

  use Fun::AstroBody qw(astro_body);

  my $astrobody = astro_body();

  print $astrobody;

=head2 Dependency

Fun::AstroBody depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;