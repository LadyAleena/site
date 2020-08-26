package Page::WordFind;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(word_find);

use File::Basename;
use Path::Tiny;

use Page::File qw(file_directory);
use Fancy::Open qw(fancy_open);
use Util::Convert qw(filify);

sub get_lone {
  my $lone = shift;
  my $lone_gender = qw(He She)[rand 2];
  my $lone_adj = qw(him her)[rand 2];
  my $lone_sent = ("$lone_gender may need saving! &#128558","Try to find $lone_adj please! Have fun!")[rand 2];
  return "There is a lone $lone in there too. $lone_sent."
}

sub word_find {
  my ($word_find, $lone, $opt) = @_;
  my $word_find_file = filify($word_find);
  my $boards_dir = file_directory('Word_finds/boards');
  my $lists_dir  = file_directory('Word_finds/lists');
  if ($opt->{'dir'}) {
    $boards_dir .= '/'.$opt->{'dir'};
    $lists_dir  .= '/'.$opt->{'dir'};
  }
  my $find_out = {
    'list' => [map { uc } fancy_open("$lists_dir/$word_find_file.txt")],
    'lonely' => $lone ? get_lone($lone) : undef,
    'board' => path("$boards_dir/$word_find_file.txt")->slurp_utf8
  };
  return $find_out;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;