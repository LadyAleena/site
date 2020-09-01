#!/usr/bin/perl
# This is the index for Fandom - Xanth.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::File qw(file_directory file_list print_file_menu);
use Page::Story qw(story);
use Page::Story::Magic::Xanth qw(Xanth_magic);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Fandom/Xanth', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Xanth);
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  my $prep = $page eq "Timeline" ? 'of' : 'in';
  $heading    = "$page $prep Xanth";
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
my $magic = Xanth_magic('page', { 'right' => ['Maeve tree', 'Tiara tree', 'Merge tree', 'Okra tree', 'Nimby tree', 'Arjayess tree', 'Baldwin', 'Jean Poole tree', 'Silhouette tree', 'Xavier tree', 'Sette', 'Champions', 'Sofias play', 'Cadence tree', 'Cans', 'Jenny tree', 'Greek'] });
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story('file' => $page_file, 'magic' => { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
