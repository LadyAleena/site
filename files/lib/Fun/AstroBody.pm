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

=head1 NAME

B<Fun::AstroBody> returns a random astronomical body to use instead of "World" in "Hello World!".

=head1 VERSION

This document describes Fun::AstroBody version 1.0.

=head1 SYNOPSIS

  use Fun::AstroBody qw(astro_body);

  my $astrobody = astro_body();

  print $astrobody;

=head1 DEPENDENCY

Fun::AstroBody depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;