package Random::Alpha;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Open qw(fancy_open);
use Util::Data qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_alpha);

my $directory = file_directory('Random/Alpha', 'data');
my @Greek_letters = fancy_open("$directory/Greek_letters.txt");;

my @consonants = (1,2,3,5,6,7,9,10,11,12,13,15,16,17,18,19,21,22,23,24,25);
my @vowels     = (0,4,8,14,20);

my %alphabet = (
  'upper case' => ['A'..'Z'],
  'lower case' => ['a'..'z']
);
$alphabet{'upper consonants'} = [@{$alphabet{'upper case'}}[@consonants]];
$alphabet{'lower consonants'} = [@{$alphabet{'lower case'}}[@consonants]];
$alphabet{'upper vowels'} = [@{$alphabet{'upper case'}}[@vowels]];
$alphabet{'lower vowels'} = [@{$alphabet{'lower case'}}[@vowels]];
$alphabet{'ascenders'}    = ['b', 'd', 'f', 'h', 'k', 'l', 't'];
$alphabet{'descenders'}   = ['g', 'j', 'p', 'q', 'y'];
$alphabet{'arches'}       = ['h', 'm', 'n'];
$alphabet{'upper bowls'}  = ['B', 'D', 'O', 'P', 'Q'];
$alphabet{'lower bowls'}  = ['b', 'd', 'o', 'p', 'q'];
$alphabet{'upper bars'}   = ['A', 'E', 'F', 'H'];
$alphabet{'lower bars'}   = ['e', 'f', 't'];
$alphabet{'dots'}         = ['i', 'j'];

$alphabet{'Greek'} = [@Greek_letters];

sub random_alpha {
  my ($user_alpha, $user_additions) = @_;
  my $random_alpha = fancy_rand(\%alphabet, $user_alpha, { caller => 'random_alpha', additions => $user_additions ? $user_additions : undef });
  return $random_alpha;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Alpha> returns a random letter of the English alphabet.

=head1 VERSION

This document describes Random::Alpha version 1.000.

=head1 SYNOPSIS

  use Random::Alpha qw(random_alpha);

  my $upper_case       = random_alpha('upper');            # returns an uppercase letter
  my $lower_case       = random_alpha('lower');            # returns a lowercase letter
  my $upper_consonant  = random_alpha('upper consonants'); # returns an uppercase consonent
  my $lower_consonant  = random_alpha('lower consonants'); # returns a lowercase consonent
  my $upper_vowel      = random_alpha('upper vowels');     # returns an uppercase vowel
  my $lower_vowel      = random_alpha('lower vowels');     # returns a lowercase vowel
  my $ascender         = random_alpha('ascenders');        # returns a b, d, f, h, k, l, or t
  my $descender        = random_alpha('descenders');       # returns a g, j, p, q, or y
  my $arch             = random_alpha('arches');           # returns an h, m, or n
  my $upper_bowl       = random_alpha{'upper bowls');      # returns a B, D, O, P, or Q
  my $lower_bowl       = random_alpha{'lower bowls');      # returns a b, d, o, p, or q
  my $upper_bar        = random_alpha('upper bars');       # returns an A, E, F, or H
  my $lower_bar        = random_alpha('lower bars');       # returns an e, f, or t
  my $dot              = random_alpha('dots');             # returns an i or j

  my $Greek            = random_alpha('Greek'); # returns a Greek letter spelled out

  print random_alpha('help') # get random_alpha options

=head1 DESCRIPTION

Random::Alpha returns a random letter of the English alphabet from whichever group you choose. The Greek option is an outlier that returns a random Greek letter spelled out.

=head2 random_alpha

=head3 Options

=head4 nothing, all, or undef

  random_alpha;
  random_alpha();
  random_alpha('all');
  random_alpha(undef);

These options will return any value in any list. You can read the options below to see all of the potential values.

=head4 upper

  random_alpha('upper');

The C<upper> option returns any uppercase letter in the English alphabet.

=head4 lower

  random_alpha('lower');

The C<lower> option returns any lowercase letter in the English alphabet.

=head4 upper consonents

  random_alpha('upper consonents');

The C<upper consonents> option returns a B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, Z, Y, or Z.

=head4 lower consonents

  random_alpha('lower consonents');

The C<lower consonents> option returns a b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, z, y, or z.

=head4 upper vowels

  random_alpha('upper vowels');

The C<upper vowels> option returns am A, E, I, O, or U.

=head4 lower vowels

  random_alpha('lower vowels');

The C<lower vowels> option returns an a, e, i, o, or u.

=head4 ascenders

  random_alpha('ascenders');

The C<ascenders> option returns a b, d, f, h, k, l, or t.

=head4 descenders

  random_alpha('descenders');

The C<descenders> option returns a g, j, p, q, or y.

=head4 arches

  random_alpha('arches');

The C<arches> option returns an h, m, or n.

=head4 upper bowls

  random_alpha('upper bowls');

The C<upper bowls> option returns a B, D, O, P, or Q.

=head4 lower bowls

  random_alpha('lower bowls');

The C<lower bowls> option returns a b, d, o, p, or q.

=head4 upper bars

  random_alpha('upper bars');

The C<upper bars> option returns an A, E, F, or H.

=head4 lower bars

  random_alpha('lower bars');

The C<lower bars> option returns an e, f, or t.

=head4 dots

  random_alpha('dots');

The C<dots> option returns an i or j.

=head4 Greek

  random_alpha('Greek');

The C<Greek> option returns Alpha, Beta, Gamma, Delta, Epsilon, Digamma, Zeta, Eta, Theta, Iota, Kappa, Lambda, Mu, Nu, Xi, Omicron, Pi, San, Qoppa, Rho, Sigma, Tau, Upsilon, Phi, Chi, Psi, Omega, or Sampi.

=head4 by keys

  random_alpha('by keys');

The C<by keys> option returns a random key listed above.

=head4 keys

  random_alpha('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_alpha('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_alpha('help');
  random_alpha('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

You can add items to the list by adding an array reference with the additional items as the second parameter.

  my @additions = ('letter 1', 'letter 2');
  random_alpha('<your option>', \@additions);

So using the above, you could add the semivowels, or glides, to the list of vowels.

  my @semivowels = ('W', 'Y');
  random_alpha('upper vowels', \@semivowels);

=head1 DEPENDENCIES

Random::Alpha depends on L<Fancy::Rand>, L<Fancy::Open>, L<Util::Data>, and L<Exporter>.

=head1 ACKNOWLEDGMENTS

Over the years I have gotten a lot of help writing Perl from the L<PerlMonks|https://www.perlmonks.org> community. I have gotten a great deal of their help over the years. So, thank you PerlMonks!

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2011, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;