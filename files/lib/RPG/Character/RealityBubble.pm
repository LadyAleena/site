package RPG::Character::RealityBubble;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(reality_bubble);

use List::Util qw(sum);

use RPG::Character::Class qw(convert_class class_level);

sub reality_bubble {
  my ($class,$opt) = @_;
  $class = convert_class($class, 'RealityBubble');
  my $level = $opt->{'level'} ? $opt->{'level'} : class_level('chaos warden', $opt->{'experience'});

  my $bubble = sum(1..$level);
  return $bubble;
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