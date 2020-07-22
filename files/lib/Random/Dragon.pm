package Random::Dragon;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand tiny_rand instant_rand);
use Fancy::Open qw(fancy_open);
use Random::Color qw(random_color);
use Random::Xanth::Dragon qw(random_Xanth_dragon random_old_Xanth_dragon);
use Random::RPG::Monster qw(random_RPG_dragon);
use Util::Data qw(file_directory);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(
  random_DreamWorks_dragon
  random_Harry_Potter_dragon
  random_Pern_dragon
  random_Xanth_dragon
  random_old_Xanth_dragon
  random_RPG_dragon
  random_dragon
);

my $directory = file_directory('Random/Dragons', 'data');
my @DreamWorks_dragons   = fancy_open("$directory/DreamWorks_dragons.txt");
my @Harry_Potter_dragons = fancy_open("$directory/Harry_Potter_dragons.txt");

my $dragons;
$dragons->{'DreamWorks'}   = [@DreamWorks_dragons];
$dragons->{'Harry Potter'} = [@Harry_Potter_dragons];

sub random_DreamWorks_dragon {
  return fancy_rand($dragons, 'DreamWorks', { caller => 'random_DreamWorks_dragon' });
}

sub random_Harry_Potter_dragon {
  return fancy_rand($dragons, 'Harry Potter', { caller => 'random_Harry_Potter_dragon' });
}

sub random_Pern_dragon {
  my $dragon_color = random_color('Pern dragon');
  my $dragon_type  = tiny_rand('dragon', 'fire lizard');
  return "$dragon_color $dragon_type";
}

sub random_dragon {
  my $dragon = instant_rand(
    random_DreamWorks_dragon,
    random_Harry_Potter_dragon,
    random_Pern_dragon,
    random_Xanth_dragon,
    random_old_Xanth_dragon,
    random_RPG_dragon,
  );
  return $dragon;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Dragon> selects random dragons from the DreamWorks Dragons, Harry Potter, Pern, and Xanth series and dragons from I<Advanced Dungeons & Dragons>, 2nd Edition.

=head1 VERSION

This document describes Random::Dragon version 1.000.

=head1 SYNOPSIS

  use Random::Dragon qw(
    random_DreamWorks_dragon
    random_Harry_Potter_dragon
    random_Pern_dragon
    random_Xanth_dragon
    random_old_Xanth_dragon
    random_RPG_dragon
    random_dragon
  );

  my $DreamWorks_dragon = random_DreamWorks_dragon;
    # selects a random dragon from the DreamWorks dragon franchise
    # based on the novels by Cressida Cowell

  my $Harry_Potter_dragon = random_Harry_Potter_dragon;
    # selects a random dragon from the Harry Potter series by J.K. Rowling

  my $Pern_dragon = random_Pern_dragon;
    # selects a random dragon or fire lizard from the Pern series by Anne McCaffrey

  my $Xanth_dragon = random_Xanth_dragon;
    # selects a random new dragon from the Xanth series by Piers Anthony

  my $old_Xanth_dragon = random_old_Xanth_dragon;
    # selects a random old dragon from the Xanth series by Piers Anthony

  my $RPG_dragon = random_RPG_dragon;
    # selects a random dragon from AD&D, 2nd ed.

  my $dragon = random_dragon;
    # selects a random dragon from all of the above

=head1 DEPENDENCIES

Random::Dragon depends on L<Fancy::Rand>, L<Fancy::Open>, L<Random::Color>, L<Random::RPG::Monster>, and L<Random::Xanth::Dragon>, L<Util::Data>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;
