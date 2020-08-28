package Page::RolePlaying::Monster;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(monster_info);

use Encode qw(encode);

use Page::Data qw(make_hash);
use Page::File qw(file_path);
use Util::Convert qw(filify);

my @monster_headings = (
  'Monster', 'Climate/Terrain', 'Frequency', 'Organization', 'Activity cycle', 'Diet', 'Intelligence', 'Treasure', 'Alignment', 'No. Appearing', 'Armor Class',
  'Movement', 'Hit Dice', 'THAC0', 'No. of Attacks', 'Damage/Attack', 'Special Attacks', 'Special Defenses', 'Magic Resistance', 'Size', 'Morale', 'XP Value'
);

my $monsters = make_hash( 'file' => ['Role_playing','monsters.txt'], 'headings' => \@monster_headings );
$monsters->{'Wild hairs'}{'Monster'} = 'Wild hairs';

sub monster_attributes {
  my ($heading_level, $in_monster) = @_;
  my $monster_data = $in_monster;
  my $attributes;

  for my $attribute (@monster_headings) {
    my $data = encode('utf-8', $monster_data->{$attribute});
    push @$attributes, qq(<strong class="caps">$attribute:</strong> $data) if $monster_data->{$attribute};
  }

  return $attributes;
}

sub monster_info {
  my ($heading_level, $in_monster, $opt) = @_;
  my $monster = $monsters->{$in_monster};
     $monster->{attributes} = monster_attributes($heading_level, $monster);

  my $file_name = filify($in_monster);
  my $file = file_path('Role_playing/Monsters', "$file_name.txt");
  open(my $fh, '<', $file) || warn "$file: $!";

  my $heading = 'description';
  my $inc = 0;
  while (my $line = <$fh>) {
    chomp $line;
    next if !$line;

    if ($line =~ /^\! /) {
      my ($marker, $text) = split(/ /, $line, 2);
      $heading = $text if ($opt->{slurp} !~ /^[yt1]/);
      $line =~ s/^\!/$heading_level/ if $heading_level;
      next if !$heading_level;
    }
    push @{$monster->{$heading}}, $line;
  }

  close($fh);

  return $monster;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;