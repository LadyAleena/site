#!/usr/bin/perl
# This is the index for Fandom - Xanth.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Minimal;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Base::Page     qw(page story);
use HTML::Elements qw(list anchor object div figure);
use Util::Convert  qw(searchify textify);
use Util::Data     qw(file_directory file_list);
use Util::Line     qw(line);
use Util::Menu     qw(file_menu);
use Util::Sort     qw(article_sort);
use Xanth::LineMagic qw(Xanth_line_magic);

my $cgi        = CGI::Minimal->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Fandom/Xanth', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map  { $_ =~ s/\.txt//; $_ =~ s/_/ /g; $_ } @pages_list;
my $heading    = q(Xanth);
my $page_file  = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  my $prep = $page eq "Timeline" ? 'of' : 'in';
  $heading     = "$page $prep Xanth";
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic = Xanth_line_magic('page');
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu);
};
my $trees_dir = '../../files/images/Fandom/Fictional_family_trees/Xanth';
my @trees_list = file_list($trees_dir);
for my $tree (@trees_list) {
  my $link = "$trees_dir/$tree";
  my $class = 'svg_group';
  if ( $tree !~ /(?:Kings|Adora|Gorbage|Incarnations|key)/ ) {
    $class .= ' right';
  }

  $magic->{textify($tree)} = sub {
    figure(6, sub {
      line(7, anchor( '', { 'href' => $link, 'target' => 'new' }));
      line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
    }, { 'class' => $class });
  };
}

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
