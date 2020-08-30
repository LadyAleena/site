package Page::Story::Magic::FamilyTree;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use List::Util qw(any);

use Page::File qw(file_list);
use Page::HTML qw(object figure anchor);
use Page::Line qw(line);
use Util::Convert qw(textify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(family_tree_magic);

sub family_tree_magic {
  my ($trees_dir, $opt) = @_;
  my $magic;

  my @trees_list = file_list($trees_dir);
  my @right_images = $opt->{right} ? @{$opt->{right}} : ();
  for my $tree_file (@trees_list) {
    my $text  = textify($tree_file);
    my $right = any { /\b$text\b/i } @right_images;
    my $link  = "$trees_dir/$tree_file";
    my $class = 'svg_group';
       $class .= ' right' if $right;
    my ($family, $source) = split(/ /, $text, 2);
    my $title = $family && $source ? "The $family family from $source." : $text;

    $magic->{$text} = sub {
      figure(6, sub {
        line(7, anchor( '', { 'href' => $link, 'target' => 'new' }));
        line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
      }, { 'class' => $class, 'title' => $title });
    };
  }

  return $magic;
}

# Version 1.0
# Depends on Page::File, Page::HTML, Page::Line, Util::Convert, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;