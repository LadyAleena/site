#!/usr/bin/perl
# This is the index for Role playing - Miscellany.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);
use Lingua::EN::Inflect qw(PL_N);

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Menu     qw(file_menu);
use Page::Story    qw(story);
use HTML::Elements qw(list);
use Util::Data     qw(file_directory file_list);
use Util::Convert  qw(searchify);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Role_playing/Miscellany', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map { s/\.txt//; s/_/ /g; $_ } @pages_list;
my $heading    = q(Role playing miscellany);
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
  list(4, 'u', $file_menu, { 'class' => 'two' });
};
for (qw(twarg throglin tralg trobold gobpry zarden), 'dark centaur') {
  my $search = searchify(ucfirst $_);
  my $text   = PL_N($_);
  $magic->{$text} = qq(A<$text|href="../Monsters/index.pl?monster=$search">);
}

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
