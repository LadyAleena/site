package Random::Descriptor;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_descriptor);

my %descriptors = (
  'good'     => [qw(good great wonderful glorious)],
  'bad'      => [qw(bad horrible awful atrocious)],
  'quality'  => [qw(excellent good average poor terrible)],
  'rarity'   => ['common', 'uncommon', 'rare', 'very rare', 'unique'],
  'reaction' => [qw(hostile unfriendly indifferent friendly)],
);

sub random_descriptor {
  my ($user_descriptor, $user_additions) = @_;
  my $descriptor = fancy_rand(\%descriptors, $user_descriptor, { caller => 'random_descriptor', additions => $user_additions ? $user_additions : undef });
  return $descriptor;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Descriptor> returns a random descriptor.

=head1 VERSION

This document describes Random::Descriptor version 1.000.

=head1 SYNOPSIS

  use Random::Descriptor qw(random_descriptor);

  my $descriptor = random_descriptor;           # returns any descriptor
  my $good     = random_descriptor('good');     # returns a random good descriptor
  my $bad      = random_descriptor('bad');      # returns a random bad descriptor
  my $quality  = random_descriptor('quality');  # returns a random quality
  my $rarity   = random_descriptor('rarity');   # returns a random rarity
  my $reaction = random_descriptor('reaction'); # returns a random reaction

  print random_descriptor('help'); # get random_descriptor options

=head1 DESCRIPTION

Random::Descriptor returns a random descriptor.

=head2 random_descriptor

=head3 Options

=head4 nothing, all, or undef

  random_descriptor;
  random_descriptor();
  random_descriptor('all');
  random_descriptor(undef);

These options will return any value in any list. You can read the options below to see all of the potential values.

=head4 good

  random_descriptor('good');

The C<good> option returns good, great, wonderful, or glorious.

=head4 bad

  random_descriptor('bad;);

The C<bad> option returns bad, horrible, awful, or atrocious.

=head4 quality

  random_descriptor('quality');

The C<quality> option returns excellent, good, average, poor, or terrible.

=head4 rarity

  random_descriptor('rarity');

The C<rarity> option returns common, uncommon, rare, very rare, or unique.

=head4 reaction

  random_descriptor('reaction');

The C<reaction> option returns hostile, unfriendly, indifferent, or friendly.

=head4 by keys

  random_descriptor('by keys');

The C<by keys> option returns a random key listed above.

=head4 keys

  random_descriptor('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_descriptor('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_descriptor('help');
  random_descriptor('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter.

  my @additions = ('descriptor 1', 'descriptor 2');
  random_descriptor('<your option>', \@additions);

=head1 DEPENDENCIES

Random::Descriptor depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;