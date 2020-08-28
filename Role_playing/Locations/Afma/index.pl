#!/usr/bin/perl
# This is the index for Role playing - Locations - Afma.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../../files/lib';
use Page::Base qw(page);
use Page::File qw(file_directory file_list print_file_menu);
use Page::Story qw(story);
use Page::Story::Magic::RolePlaying qw(Afma_flag_magic);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Role_playing/Locations/Afma', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Afma);
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading    = $page eq 'Aleena' ? 'Aleena, the Overpower of Afa and Afma' : $page;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
my $magic = Afma_flag_magic;
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story('file' => $page_file, 'magic' => { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
