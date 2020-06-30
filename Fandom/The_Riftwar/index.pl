#!/usr/bin/perl
# This is the index for Fandom - The Riftwar.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Minimal;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Base::Page     qw(page story);
use HTML::Elements qw(list anchor);
use Util::Convert  qw(searchify);
use Util::Data     qw(file_directory file_list);
use Util::Menu     qw(file_menu);
use Util::Sort     qw(article_sort);

my $cgi        = CGI::Minimal->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Fandom/The_Riftwar', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map  { $_ =~ s/\.txt//; $_ =~ s/_/ /g; $_ } @pages_list;
my $heading    = q(The Riftwar);
my $page_file  = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading     = $page;
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic;
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu);
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
