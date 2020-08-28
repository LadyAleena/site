#!/usr/bin/perl
# This is the index for Role_playing - Player_characters.
use strict;
use warnings;

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);
use Lingua::EN::Inflect qw(PL_N);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Page::HTML qw(section list table);
use Page::Story qw(story);
use Page::Number::Pretty qw(commify);
use Page::RolePlaying::Character::AbilityScores qw(ability_box);
use Page::RolePlaying::Character::Info qw(pc_info_list);
use Fancy::Join::Defined   qw(join_defined);
use RPG::Character::Alignment qw(expand_alignment);
use Page::RolePlaying::Character::Class qw(player_classes_simple);
use Util::Convert qw(idify);

my $cgi  = CGI::Simple->new;
my $page = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;

my $player_characters = make_hash(
  'file' => ['Role_playing','player_characters.txt'],
  'headings' => ['full name', 'id', 'last name', 'first name', qw(alignment class+ experience race special_race gender strength dexterity constitution intelligence wisdom charisma)],
);

my @pc_info_headings = qw(experience alignment race gender);

my $heading = $page && $page eq 'House rules' ? 'House rules' : undef;

page( 'heading' => $heading, 'selected' => $page, 'code' => sub {
  if ($page && $page eq 'House rules') {
    my $pages_dir = file_directory('Role_playing/Player_characters', 'text');
    story('file' => "$pages_dir/House_rules.txt");
  }
  else {
    section(3,
      'I have taken down all of the individual pages for my player characters for a while. I am revamping this whole section of my site and the current files are a mess. Please bear with me as I working on getting them back online.'
    );
    for my $character (sort {$a->{'last name'} cmp $b->{'last name'} || $a->{'first name'} cmp $b->{'first name'}} values %$player_characters) {
      my $name = $character->{'full name'};

      my $ability_scores = ability_box($character);
      my $race = join_defined(' / ', ($character->{'race'}, $character->{'special_race'}));

      my @classes = @{$character->{'class'}};
      my $class_key = PL_N('class', scalar @classes);
      unshift @pc_info_headings, $class_key;

      my %pc_info = (
        experience => commify($character->{experience} + 0),
        alignment  => expand_alignment($character->{alignment}),
        gender     => $character->{gender},
        race       => $race
      );
      $pc_info{$class_key} = player_classes_simple(\@classes);

      section(3, sub {
        table(4, { rows => [['whead', $ability_scores]], class => 'ab_box', 'caption' => 'Ability scores' });
        list(4, 'u', pc_info_list(\%pc_info, \@pc_info_headings), { 'class' => 'headed' });
      }, { 'heading' => [2, $name, { id => idify($name) }], 'class' => 'pc_top' });

      shift @pc_info_headings;
    }
  }
});
