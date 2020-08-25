#!/usr/bin/perl
# This is the site index.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib 'files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use Page::File qw(file_list);
use Page::Story::Magic::IRC              qw(irc_magic);
use Page::Story::Magic::Programs         qw(program_magic);
use Page::Story::Magic::PlayerCharacters qw(pc_magic);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = 'files/text';
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
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic = {
  %{&program_magic},
  %{&pc_magic},
  %{&irc_magic}
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'line magic' => $magic, 'doc magic' => $magic })
  }
);
