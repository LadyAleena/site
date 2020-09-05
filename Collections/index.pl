#!/usr/bin/perl
# This is the index for Collections.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use FindBin qw($Bin);
use HTML::Entities qw(encode_entities);

use lib "$Bin/../files/lib";
use Page::Base qw(page);
use Page::File qw(file_directory file_list print_file_menu);
use Page::Story qw(story);
use Page::Story::Magic::Collection qw(collection_magic);
use Page::Story::Magic::Programs   qw(program_magic);
use Random::Dragon qw(random_DreamWorks_dragon random_Harry_Potter_dragon random_Pern_dragon);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Collections', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Lady Aleena's collections);
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading    = q(Lady Aleena's ).lc "$page collection";
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
my $magic = $page && $page eq 'Program' ? program_magic : collection_magic;
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };
$magic->{'DW dragon'}   = lc random_DreamWorks_dragon;
$magic->{'HP dragon'}   = lc random_Harry_Potter_dragon;
$magic->{'Pern dragon'} = lc random_Pern_dragon;

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story('file' => $page_file, 'magic' => { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
