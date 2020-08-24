package Random::Alpha;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);
use Fancy::Open qw(fancy_open);
use Page::List::File qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_alpha);

my $directory = file_directory('Random/Alpha', 'data');
my @Greek_letters  = fancy_open("$directory/Greek_letters.txt");
my @Greek_upper_ce = fancy_open("$directory/Greek_upper_ce.txt");
my @Greek_lower_ce = fancy_open("$directory/Greek_lower_ce.txt");
my @Hebrew_letters = fancy_open("$directory/Hebrew.txt");
my @Hebrew_ce      = fancy_open("$directory/Hebrew_ce.txt");
my @Hebew_final_ce = fancy_open("$directory/Hebrew_final_ce.txt");

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

$alphabet{'Greek named'}    = [@Greek_letters];
$alphabet{'Greek upper'}    = [qw(Α Β Γ Δ Ε Ζ Η Θ Ι Κ Λ Μ Ν Ξ Ο Π Ρ Σ Τ Υ Φ Χ Ψ Ω)];
$alphabet{'Greek lower'}    = [qw(α β γ δ ε ζ η θ ι κ λ μ ν ξ ο π ρ σ τ υ φ χ ψ ω)];
$alphabet{'Greek upper ce'} = [@Greek_upper_ce];
$alphabet{'Greek lower ce'} = [@Greek_lower_ce];

$alphabet{'Hebrew named'}     = [@Hebrew_letters];
$alphabet{'Hebrew letters'}   = [qw(א ב ג ד ה ו ז ח ט י כ ל מ נ ס ע פ צ ק ר ש ת װ ױ ײ)];
$alphabet{'Hebrew finals'}    = [qw(א ב ג ד ה ו ז ח ט י ך ל ם ן ס ע ף ץ ק ר ש ת װ ױ ײ)];
$alphabet{'Hebrew ce'}        = [@Hebrew_ce];
$alphabet{'Hebrew finals ce'} = [@Hebew_final_ce];

sub random_alpha {
  my ($user_alpha, $user_additions) = @_;
  my $random_alpha = fancy_rand(\%alphabet, $user_alpha, { caller => 'random_alpha', additions => $user_additions ? $user_additions : undef });
  return $random_alpha;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
