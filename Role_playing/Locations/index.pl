#!/usr/bin/perl
# This is the index for Role playing - Locations.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use Page::List::File qw(file_directory file_list file_menu);
use HTML::Elements qw(list definition_list);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = file_directory('Role_playing/Locations', 'text');
my @pages     = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article', 'text' => 1 });
my $heading   = q(Role playing locations);
my $page_file = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading    = $page eq 'Olakeen' ? 'Olakeen - The City of Money and Magic' : $page;
  $page_file  = "$pages_dir/$page.txt";
  $page_file  =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

my $magic;
$magic->{'pages'} = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu);
};
# Start Olakeen holidays
$magic->{'Holidays'} = sub {
  my $directory = 'Role_playing/Locations/Olakeen';
  my $Olakeen_holidays = make_array( 'file' => [$directory, 'Holidays.txt'], 'headings' => [qw(term date celebrations)]);
  for my $bare_term (@{$Olakeen_holidays}) {
    my $term = $bare_term->{'term'};
    $bare_term->{'term'} = [$term, { 'class' => 'holiday' }];
  }
  definition_list(5, $Olakeen_holidays, { 'headings' => [qw(date celebrations)], 'span class' => 'definition_heading' } );
};
# End Olakeen holidays

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
