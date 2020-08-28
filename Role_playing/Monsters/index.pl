#!/usr/bin/perl
# This is the index for Role_playing - Monsters.
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Entities qw(encode_entities);
use Lingua::EN::Inflect qw(A);
use File::Temp qw(tempfile);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::File qw(file_menu);
use Page::HTML qw(section paragraph list);
use Page::Story qw(story);
use Page::RolePlaying::Monster qw(monster_info);
use Random::RPG::Monster qw(random_monster random_monster_list);

my $multi_monsters = {
  'Throglin' => ['Throglin', 'Freshwater throglin', 'Saltwater throglin'],
  'Tralg'    => ['Arctic tralg', 'Desert tralg', 'Two-headed tralg'],
  'Twarg'    => ['Hill twarg', 'Mountain twarg', 'Jungle twarg'],
};

my $random_monster = A(random_monster);
my @selects = ('Chaos elemental-kin', 'Daemar', 'Dark centaur', 'Demi-lycanthrope', 'Dragod', 'Eldent', 'Gobpry', 'Phase elemental', 'Rainbow dragonette', 'Throglin', 'Tralg', 'Trobold', 'Twarg', 'Zarden', 'Random monsters');

my $cgi = CGI::Simple->new;
my $select = $cgi->param('monster') ? encode_entities($cgi->param('monster'),'/<>"') : undef;

my $head = $select && grep(/\Q$select\E/, @selects) ? $select : undef;
my $file_menu = file_menu('monster', \@selects, $select);

page( 'heading' => $head, 'file menu' => $file_menu, code => sub {
  if ($select && grep(/\Q$select\E/, @selects)) {
    if ($select eq 'Random monsters') {
      section(3, sub { list(5, 'u', random_monster_list) });
    }
    else {
      my $monster_description;
      my $class = "monster";
      if ($multi_monsters->{$select}) {
        $class .= ' multiple';
        my $monster_attributes;
        for my $sub_monster (@{$multi_monsters->{$select}}) {
          my $new_monster = monster_info(3, $sub_monster, { slurp => 'yes' });
          push @$monster_attributes, $new_monster->{attributes};
          push @$monster_description, ( "2 $sub_monster", @{$new_monster->{description}}) if $new_monster->{description};
        }
        section(3, sub {
          for my $list (@$monster_attributes) {
            list(4, 'u', $list, { class => 'monster multi' }); # the lists for all the monsters are printed before descriptions
          }
        }, { 'class' => $class });
      }
      else {
        $class .= ' single';
        my $new_monster = monster_info(2, $select, { slurp => 'yes' });
        my $attributes  = $new_monster->{attributes};
        $monster_description = $new_monster->{description};
        section(3, sub {
          list(4, 'u', $attributes, { class => 'monster two' });
        }, { 'class' => $class });
      }

      # the descriptions for all the monsters are printed after the lists
      my ($desc_fh, $filename) = tempfile();
      $desc_fh->print(map { "$_\n" } @$monster_description);
      $desc_fh->close();
      story('file' => $filename);
    }
  }
  else {
    section (3, sub {
      paragraph(3, "You can read about several new monsters or generate a list of random monsters from the <i>Monstrous Manual</i> and its many appendixes. Look there's $random_monster!");
      list(5, 'u', $file_menu, { 'class' => 'two' });
    });
  }
});