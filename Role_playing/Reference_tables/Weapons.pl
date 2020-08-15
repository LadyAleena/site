#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Base::Page     qw(page);
use Fancy::Join::Defined qw(join_defined);
use HTML::Elements qw(section paragraph table anchor);
use HTML::Forms    qw(tiny_select);
use RPG::WeaponName qw(display_weapon);
use Util::Data     qw(make_hash);

my $cgi = CGI::Simple->new;
my $size  = $cgi->param('size') ? encode_entities($cgi->param('size'), '<>"') : undef;
my $type  = $cgi->param('type') ? encode_entities($cgi->param('type'), '<>"') : undef;
my $broad = $cgi->param('broad_group') ? encode_entities($cgi->param('broad_group'), '<>"') : undef;
my $tight = $cgi->param('tight_group') ? encode_entities($cgi->param('tight_group'), '<>"') : undef;

my $size_letter = $size ? substr($size, 0, 1) : undef;
my $type_letter = $type ? substr($type, 0, 1) : undef;

my @headings = ('Weapon','#AT','Dmg(S/M)','Dmg(L)','Range','Weight','Size','Type','Speed','KO');

my $weapons_list = make_hash(
  'file' => ['Role_playing/Reference_tables','Weapons.txt'],
  'headings' => [@headings, 'broad group', 'tight group', 'value']
);

my @rows;
for my $weapon (sort { $a->{'Weapon'} cmp $b->{'Weapon'} } values %$weapons_list) {
  next if $size  && (!$weapon->{'Size'} || $weapon->{'Size'} !~ /$size_letter/);
  next if $type  && (!$weapon->{'Type'} || $weapon->{'Type'} !~ /$type_letter/);
  next if $broad && (!$weapon->{'broad group'} || $weapon->{'broad group'} ne $broad);
  next if $tight && (!$weapon->{'tight group'} || $weapon->{'tight group'} ne $tight);
  $weapon->{'Weapon'} = display_weapon('text' => $weapon->{'Weapon'});
  push @rows, [map($weapon->{$_} ? $weapon->{$_} : '', @headings)];
}

my $head = ($size || $type) && ($broad || $tight)   ? join_defined(' ', ($size, $type, $broad, $tight)) :
           ($size || $type) && (!$broad || !$tight) ? join_defined(' ', ($size, $type)).' weapons' :
           (!$size && !$type) && ($broad || $tight) ? join_defined(' ', ($broad, $tight)) : undef;

page( 'heading' => $head ? ucfirst lc $head : undef, 'code' => sub {
  section(3, sub {
    paragraph(4,qq{These weapons are from Advanced Dungeons &amp; Dragons, 2nd edition. You can select the weapons you wish to view by size, type, or broad or tight group. Please see the source books for the descriptions. If you know of more, please email me.});
  });
  tiny_select(4, {
    'class'    => 'proficiency',
    'location' => 'Weapons.pl',
    'file'     => ['Role_playing/Reference_tables','Weapons_select.txt'],
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