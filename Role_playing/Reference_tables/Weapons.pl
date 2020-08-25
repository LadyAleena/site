#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Page::HTML qw(section paragraph table);
use Page::Forms qw(tiny_select);
use Page::CGI::Param qw(get_cgi_param);
use Fancy::Join::Defined qw(join_defined);
use RPG::WeaponName qw(display_weapon);

my $cgi = CGI::Simple->new;
my $size  = get_cgi_param($cgi, 'size');
my $type  = get_cgi_param($cgi, 'type');
my $broad = get_cgi_param($cgi, 'broad_group');
my $tight = get_cgi_param($cgi, 'tight_group');

my $size_letter = $size ? substr($size, 0, 1) : undef;
my $type_letter = $type ? substr($type, 0, 1) : undef;

my @headings = ('Weapon','#AT','Dmg(S/M)','Dmg(L)','Range','Weight','Size','Type','Speed','KO');

my $ref_dir = file_directory('Role_playing/Reference_tables');

my $weapons_list = make_hash( 'file' => "$ref_dir/Weapons.txt", 'headings' => [@headings, 'broad group', 'tight group', 'value'] );

my @rows;
for my $weapon (sort { $a->{'Weapon'} cmp $b->{'Weapon'} } values %$weapons_list) {
  next if $size  && (!$weapon->{'Size'} || $weapon->{'Size'} !~ /$size_letter/);
  next if $type  && (!$weapon->{'Type'} || $weapon->{'Type'} !~ /$type_letter/);
  next if $broad && (!$weapon->{'broad group'} || $weapon->{'broad group'} ne $broad);
  next if $tight && (!$weapon->{'tight group'} || $weapon->{'tight group'} ne $tight);
  $weapon->{'Weapon'} = display_weapon('text' => $weapon->{'Weapon'});
  push @rows, [map($weapon->{$_} ? $weapon->{$_} : '', @headings)];
}

my $head = ($size || $type) && ($broad || $tight)   ? join_defined(' ', ($size, $type, lc $broad, lc $tight)) :
           ($size || $type) && (!$broad || !$tight) ? join_defined(' ', ($size, $type)).' weapons' :
           (!$size && !$type) && ($broad || $tight) ? join_defined(' ', ($broad, $tight)) : undef;

page( 'heading' => $head ? ucfirst $head : undef, 'code' => sub {
  section(3, sub {
    paragraph(4,qq{These weapons are from Advanced Dungeons &amp; Dragons, 2nd edition. You can select the weapons you wish to view by size, type, or broad or tight group. Please see the source books for the descriptions. If you know of more, please email me.});
  });
  tiny_select(4, {
    'class'    => 'proficiency',
    'location' => 'Weapons.pl',
    'file'     => "$ref_dir/Weapons_select.txt",
    'order'    => ['size', 'type', 'broad_group', 'tight_group']
  });
  section(3, sub {
    table(4, {
      'class' => 'proficiency',
      'thead' => { 'rows' => [['header',[\@headings]]]},
      'rows'  => [['data',\@rows]]
     });
  }, { 'class' => 'rp_table' });
});