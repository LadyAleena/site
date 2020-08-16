#!/usr/bin/perl
# This is the index for Role playing - Magic items.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use Page::Story::Magic::MagicItem qw(magic_item_magic);
use HTML::Elements qw(list anchor);
use Util::Convert  qw(searchify textify);
use Util::Data     qw(file_directory file_list);
use Util::Menu     qw(file_menu);
use Util::Sort     qw(article_sort name_sort);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Role_playing/Magic_items', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map  { $_ =~ s/\.txt//; $_ =~ s/_/ /g; $_ } @pages_list;
my $heading    = q(Magic items);
my $page_file  = "$pages_dir/index.txt";
if ( $page && ( grep { $_ eq $page } @pages or $page eq 'magic items of the specialist' )) {
  $heading     = $page eq 'Miscellaneous' ? 'Miscellaneous magic items' :
                 $page eq 'Bags and bottles' ? 'Magical containers' :
                 $page eq 'Liquids' ? 'Magical liquids and oils' :
                 $page eq 'magic items of the specialist' ? ucfirst $page :
                 'Magical '. lc $page;
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic = magic_item_magic;
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu, { 'class' => 'two' });
};
$magic->{'spellbooks'} = sub {
  my $spellbook_dir  = file_directory('Role_playing/Player_characters/Spellbooks');
  my @spellbook_list = sort { name_sort(textify($a),textify($b)) } file_list($spellbook_dir);
  my @spellbooks;
  for my $spellbook (@spellbook_list) {
    my $text = textify($spellbook);
    my $search = searchify($text);
    push @spellbooks, anchor($text, { href => qq(../Player_characters/Spellbooks.pl?spellbook=$search) });
  }
  list(4, 'u', \@spellbooks, { 'class' => 'three' })
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
