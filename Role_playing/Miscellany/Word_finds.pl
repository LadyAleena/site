#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base     qw(page);
use HTML::Elements qw(section paragraph list span pre);
use Util::Menu     qw(file_menu);
use Util::WordFind qw(word_find);

my %finds = (
  'Monsters Galore' => 'HUMAN',
  'Undead'          => 'UNDEAD SLAYER'
);

my $cgi = CGI::Simple->new;
my $select = $cgi->param('word find') ? encode_entities($cgi->param('word find'),'<>"') : undef;
my $head = $select && $finds{$select} ? "$select word find" : undef;
my $file_menu = file_menu('word find', [sort keys %finds], $select);

page( 'heading' => $head, 'code' => sub {
  if ($select && $finds{$select}) {
    my $lonely = span($finds{$select}, { 'class' => 'word_find' });
    my $lone = "There is a lone $lonely in there too.";
    my $word_find = word_find($select, $finds{$select});

    section(3, sub {
      pre(3, sub { print $word_find->{'board'} }, { 'class' => 'word_find'});
    });
    section(3, sub {
      list(4, 'u', $word_find->{'list'}, { class => 'word_find four' });
      paragraph(4, join(' ', ($lone, $word_find->{'lonely'})));
    }, { 'heading' => [2, 'Find these monsters'] });
  }
  else {
    section(3, sub {
      paragraph(5, "Please select a puzzle:");
      list(5, 'u', $file_menu);
    });
  }
});