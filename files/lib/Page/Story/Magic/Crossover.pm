package Page::Story::Magic::Crossover;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::Util qw(any);

use Page::File qw(file_directory file_list);
use Page::HTML qw(anchor object figure);
use Page::Line qw(line);
use Page::Story::Magic::Movie qw(movie_magic);
use Util::Convert qw(textify searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(crossover_magic);

sub crossover_magic {
  my %opt = @_;

  my $magic = movie_magic( dots => $opt{dots} );

# Start SVG groups

  my $open_directory = file_directory('Fandom/Crossovers', 'imagesd');
  my $link_directory = file_directory('Fandom/Crossovers', 'images');
  my @cross_files = file_list($open_directory);
  my @big_images = $opt{big} ? @{$opt{big}} : ();
  for my $cross_file (@cross_files) {
    my $big   = any { /\b$_\b/i } @big_images;
    my $link  = "$link_directory/$cross_file";
    my $text  = textify($cross_file);
    my $class = 'svg_group';
       $class .= ' right' unless $big;
    my $title = "$text chart";

    $magic->{$text} = sub {
      figure(6, sub {
        line(7, anchor( '', { 'href' => $link, 'target' => 'new' } )) if $big;
        line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'} )); # object used instead of img, b/c img won't render svg properly
      }, { 'class' => "$class", 'title' => $title });
    };
  }

# End SVG groups
# Start Thomas Holbrook links

  $magic->{'Thommy'} = qq(A<Thomas Holbrook&#700;s groups|href="http://www.poobala.com/crossoverlistb.html#byreality" target="new">);
  $magic->{'TH-DCU'} = qq(A<Thomas Holbrook&#700;s DCU group|href="http://www.poobala.com/crossoverlistb.html#DCU" target="new">);
  for my $num (1..38) {
    $magic->{"TH-$num"} = qq(A<Thomas Holbrook&#700;s group $num|href="http://www.poobala.com/crossoverlistb.html#G$num" target="new">);
  }

# End Thomas Holbrook links

  return $magic;
}

# Version 1.0
# Depends on Page::File, Page::HTML, Page::Line, Page::Story::Magic::Movie, Util::Convert, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;