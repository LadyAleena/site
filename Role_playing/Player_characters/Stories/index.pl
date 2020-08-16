#!/usr/bin/perl
# This is the index for Role playing - Player characters - Stories.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story passage);
use Page::Story::Magic qw(pc_magic);
use Page::RolePlaying::Spell::List qw(spell_data);
use HTML::Elements qw(list anchor heading);
use Util::Convert  qw(searchify);
use Util::Data     qw(file_directory file_list);
use Util::Menu     qw(file_menu);
use Util::Sort     qw(article_sort);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Role_playing/Player_characters/Stories', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map  { $_ =~ s/\.txt//; $_ =~ s/_/ /g; $_ } @pages_list;
my $heading    = q(Player character stories);
my $page_file  = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading     = $page;
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic = pc_magic;
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu);
};
$magic->{'spells'} = sub {
  for my $spell_in ('Find Beacon','Teleport Beacon','Secure Teleport') {
    my $spell = spell_data($spell_in);
    heading(4, 3, $spell->{'heading'});
    list(5, 'u', @{$spell->{'stats'}});
    passage(5, $spell->{'description'});
  }
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
