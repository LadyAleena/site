#!/usr/bin/perl
# This is the index for Role playing - Reference tables.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use Page::Data     qw(make_array);
use Page::List::File qw(file_directory file_list print_file_menu);
use HTML::Elements qw(definition_list object figure);
use Page::Line     qw(line);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Role_playing/Reference_tables', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Role playing references);
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading    = $page;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic;
$magic->{'pages'} = sub { print_file_menu('page', \@pages, $page, 2) };
$magic->{'equipment'} = sub {
  my @def_headings = ('cost', 'weight', 'items included');
  my $definition_list = make_array( 'file' => ['Role_playing/Reference_tables', 'Equipment_kits.txt'], 'headings' => ['term', @def_headings] );
  definition_list(4, $definition_list, { 'headings' => \@def_headings, 'span class' => 'definition_heading' })
};
$magic->{'alignment chart'} = sub {
  my $exp_align_link = '../../files/images/Role_playing/Expanded_alignments_scores.svg';
  figure(6, sub {
    line(7, object( '', { 'data' => $exp_align_link, 'type' => 'image/svg+xml', 'title' => 'Expanded Alignment Chart' })); # object used instead of img, b/c img won't render svg properly
  }, { 'id' => 'alignment_chart', 'class' => 'svg_group centered' });
};

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
