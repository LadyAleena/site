#!/usr/bin/perl
# This is the index for Miscellany - Geeky thoughts.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);
use Math::BigInt;

use lib '../../files/lib';
use Page::Base     qw(page);
use Page::Menu     qw(file_menu);
use Page::Story    qw(story);
use Page::Line     qw(line);
use HTML::Elements qw(list anchor object figure img definition_list table);
use Util::Convert  qw(searchify);
use Util::Data     qw(file_directory file_list make_array);
use Util::Number   qw(commify);
use Util::Sort     qw(article_sort);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Miscellany/Geeky_thoughts', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map  { $_ =~ s/\.txt//; $_ =~ s/_/ /g; $_ } @pages_list;
my $heading    = q(Lady Aleena's geeky thoughts);
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
# Start Chess variants
$magic->{'pieces'} = sub {
  my $definition_list = make_array( 'file' => ['Miscellany', 'royal_chess.txt'], 'headings' => ['term', 'definition'] );
  definition_list(5, $definition_list)
};
$magic->{board} = sub {
  my $link = '../../files/images/Miscellany/royal_chess_text.svg';
  figure(6, sub {
    line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
  }, { 'id' => 'royal_chess_board', 'class' => 'svg_group centered'  });
};
# End Chess variants
# Start Numeration scale
$magic->{'scale'} = sub {
  my @scale = qw(m d tr tetr pent hex hept oct enn dec hendec dodec triskaidec tetrakaidec pentakaidec hexakaidec heptakaidec octokaidec ennaekaidec icosadec icosihen icosid icositr icositetr icosipent icosihex icosihept icosioct icosienn);
  my $i = 1;
  my @rows;
  for (@scale) {
    my $number = commify(Math::BigInt->new(10**(3*$i++)));
    push @rows, ["${_}illion", $number];
  }

  table(4, {
    'id' => 'numeration_scale_data',
    'class' => 'number',
    'rows' => [
      ['header', [['Name', 'Number']]],
      ['data', \@rows]
    ],
  })
};
# End Numeration scale

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
