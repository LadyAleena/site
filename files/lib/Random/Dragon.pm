package Random::Dragon;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
use File::ShareDir qw(module_dir);

use Fancy::Rand qw(fancy_rand tiny_rand instant_rand);
use Fancy::Open qw(fancy_open);
use Random::Color qw(random_color);
use Random::Xanth::Dragon qw(random_Xanth_dragon random_old_Xanth_dragon);
use Random::RPG::Monster qw(random_RPG_dragon);

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

my $directory = module_dir('Random::Dragon');
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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
