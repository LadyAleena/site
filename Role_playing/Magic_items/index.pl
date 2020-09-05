#!/usr/bin/perl
# This is the index for Role playing - Magic items.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use FindBin qw($Bin);
use HTML::Entities qw(encode_entities);

use lib "$Bin/../../files/lib";
use Page::Base qw(page);
use Page::File qw(file_directory file_list print_file_menu);
use Page::Story qw(story);
use Page::Story::Magic::MagicItem qw(magic_item_magic);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Role_playing/Magic_items', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Magic items);
my $page_file = "$pages_dir/index.txt";
if ( $page && ( grep { $_ eq $page } @pages or $page eq 'magic items of the specialist' )) {
  $heading    = $page eq 'Miscellaneous' ? 'Miscellaneous magic items' :
                $page eq 'Bags and bottles' ? 'Magical containers' :
                $page eq 'Liquids' ? 'Magical liquids and oils' :
                $page eq 'magic items of the specialist' ? ucfirst $page :
                'Magical '. lc $page;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
my $magic = magic_item_magic;
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story('file' => $page_file, 'magic' => { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
