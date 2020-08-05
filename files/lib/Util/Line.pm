package Util::Line;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(line rline);

sub rline {
  my ($tab,$line) = @_;
  return q(  ) x $tab.qq($line\n);
}

sub line {
  print rline(@_);
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;