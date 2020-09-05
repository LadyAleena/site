#!/usr/bin/perl
# This is the site index.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use FindBin qw($Bin);
use HTML::Entities qw(encode_entities);

use lib "$Bin/files/lib";
use Page::Base qw(page);
use Page::File qw(file_directory file_list);
use Page::Story qw(story);
use Page::Story::Magic::IRC              qw(irc_magic);
use Page::Story::Magic::Programs         qw(program_magic);
use Page::Story::Magic::PlayerCharacters qw(pc_magic);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory(undef, 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 0, 'sort' => 'article', 'text' => 1 });
my $heading   = 'index';
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading    = $page eq 'about' ? 'About Lady Aleena' :
                $page eq 'irc'   ? 'IRC channels I visit' :
                undef;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
my $magic = {
  %{&program_magic},
  %{&pc_magic},
  %{&irc_magic}
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story('file' => $page_file, 'magic' => { 'line magic' => $magic, 'doc magic' => $magic })
  }
);
