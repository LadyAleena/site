package Random::Alpha;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(random_alpha);

use Fancy::Rand qw(fancy_rand);
use Util::Data qw(file_directory);

my $directory = file_directory('Random/Colors', 'data');

open(my $Greek_fh, '<', "$directory/Greek_letters.txt") ||
  die "Can not open $directory/Greek_letters.txt. $!";
my @Greek_letters = map { chomp; $_ } <$Greek_fh>;
close($Greek_fh);

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
$alphabet{'crosses and dots'} = ['f', 'i', 'j', 't'];

$alphabet{'Greek'} = [@Greek_letters];

sub random_alpha {
  my ($user_alpha, $user_additions) = @_;
  my $random_alpha = fancy_rand(\%alphabet, $user_alpha, { caller => 'random_alpha', additions => $user_additions ? $user_additions : undef });
  return $random_alpha;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Alpha> selects random letters of the English alphabet.

=head1 SYNOPSIS

  use Random::Alpha qw(random_alpha);

  my $upper_case       = random_alpha('upper');            # selects an upper case letter
  my $lower_case       = random_alpha('lower');            # selects a lower case letter
  my $upper_consonant  = random_alpha('upper consonants'); # selects an B, C, D, F, G, H, J, K, L, M, N, P, Q, R, S, T, V, W, Z, Y, or Z
  my $lower_consonant  = random_alpha('lower consonants'); # selects an b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, z, y, or z
  my $upper_vowel      = random_alpha('upper vowels');     # selects an A, E, I, O, or U
  my $lower_vowel      = random_alpha('lower vowels');     # selects an a, e, i, o, or u
  my $ascender         = random_alpha('ascenders');        # selects a b, d, f, h, k, l, or t
  my $descender        = random_alpha('descenders');       # selects a g, j, p, q, or y
  my $cross_or_dot     = random_alpha('crosses and dots'); # selects an f, i, j, or t

  my $Greek        = random_alpha('Greek'); # selects a Greek letter spelled out

  print random_alpha('help') # get random_alpha options

=head1 DEPENDENCIES

Random::Alpha depends on L<Fancy::Rand>, L<Util::Data>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;