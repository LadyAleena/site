#!/usr/bin/perl
# This is the index for Fandom - Fictional family trees.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Menu     qw(file_menu);
use Page::Story    qw(story);
use HTML::Elements qw(list object figure anchor);
use Util::Data     qw(file_directory file_list);
use Page::Line     qw(line);
use Util::Convert  qw(textify);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Fandom/Fictional_family_trees', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map { s/\.txt//; s/_/ /g; $_ } @pages_list;
my $heading    = q(Fictional family trees);
my $page_file  = "$pages_dir/index.txt";
my $trees_dir = '../../files/images/Fandom/Fictional_family_trees';
if ( $page && grep { $_ eq $page } @pages ) {
  $heading     = $page;
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;

  my $page_dir = $page;
     $page_dir =~ s/ family trees$//;
     $page_dir =~ s/ /_/g;
   $trees_dir .= "/$page_dir";
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic;
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu, { 'class' => 'two' });
};

my @trees_list = file_list($trees_dir);
for my $tree_file (@trees_list) {
  my $link = "$trees_dir/$tree_file";
  my $class = 'svg_group';
  my $text = textify($tree_file);
  my ($family, $source) = split(/ /, $text, 2);
  my $title = $family && $source ? "The $family family from $source." : $text;

  $magic->{$text} = sub {
    figure(6, sub {
      line(7, anchor( '', { 'href' => $link, 'target' => 'new' }));
      line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
    }, { 'class' => $class, 'title' => $title });
  };
}

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
