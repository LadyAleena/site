#!/usr/bin/perl
use strict;
use warnings;

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(passage);
use Page::List::File qw(file_menu);
use Page::RolePlaying::Spell::List qw(spell_data);
use HTML::Elements qw(section paragraph list);
use Util::Sort     qw(article_sort);

my %scrolls = (
  'Councilor\'s path scroll' => ['Hypnotism','Suggestion','Domination','Mass Suggestion'],
  'Illusion scroll' => ['Detect Illusion','Illusionary Script','Protection from Illusions','Dispel Illusion','Illusionary Wall','Advanced Illusion',"Protection from Illusions, 10' Radius",'Permanent Illusion','Programmed Illusion'],
  'Invisible scroll' => ['Detect Invisibility','Invisibility',"Invisibility, 10' Radius",'Improved Invisibility','Mass Invisibility'],
  'Magic item scroll' => ['Identify','Enchant an Item','Permanency'],
  'Misty road scroll' => ['Wall of Fog','Fog Cloud','Stinking Cloud','Hold Vapor','Solid Fog','Cloudkill','Mind Fog','Death Fog','Incendiary Cloud'],
  'Prismatic scroll' => ['Magic Missile','Continual Light','Dispel Magic','Cone of Cold','Gust of Wind','Passwall','Disintegrate','Prismatic Spray','Prismatic Wall','Prismatic Sphere'],
  'Scroll of colors' => ['Color','Color Spray','Rainbow Pattern'],
  'The path of terror' => ['Spook','Scare','Fear','Phantasmal Killer','Weird'],
);

my @selects = sort { article_sort($a,$b) } keys %scrolls;

my $cgi = CGI::Simple->new;
my $select = encode_entities($cgi->param('spell scroll'),'<>"');
my $head = $select && grep(/\Q$select\E/, @selects) ? $select : undef;
my $file_menu = file_menu('spell scroll', \@selects);

page( 'heading' => $head, 'file menu' => $file_menu, 'code' => sub {
  if ($select && grep(/\Q$select\E/, @selects)) {
    for my $spell_in (@{$scrolls{$select}}) {
      my $spell = spell_data($spell_in);
      section(3, sub {
        list(5, 'u', @{$spell->{'stats'}});
        passage(5, $spell->{'description'});
      }, { 'heading' => [2, $spell->{'heading'}] });
    }
  }
  else {
    section (3, sub {
      paragraph(3, "Pull up a chair and read a scroll.");
      list(5, 'u', $file_menu, { 'class' => 'two' });
    });
  }
});