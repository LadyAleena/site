package SVG::MakeRect;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(make_rect);

use List::Util qw(min max uniq);
use Math::Round qw(nearest);

sub make_rect {
  my $line = shift;

  my @attributes = ( $line =~ /(\w+\=".+?")/g );        # get all attributes from polygon

  my @points_attribute = grep { /points/ } @attributes; # get points attribute of polygon in array
  my $points = $points_attribute[0];                    # get points attribute of polygon as string
     $points =~ s/.+="(.+)"/$1/;                        # get points from attribute
  my $points_list = [uniq split(/ /,$points)];          # get unique pairs of points

  my $new_value;
  if (@$points_list == 4) {
    my @xs;
    my @ys;
    for my $point (@$points_list) {
      my ($x, $y) = split(/,/, $point);                 # get x and y points from pair of points
      push @xs, nearest(.1, $x);                        # put x into an array of xs after rounding to nearest tenth
      push @ys, nearest(.1, $y);                        # put y into an array of ys after rounding to nearest tenth
    }

    my $uniqxs = uniq(@xs);                             # find amount of unique xs
    my $uniqys = uniq(@ys);                             # find amount of unique ys

    if ( $uniqxs == 2 && $uniqys == 2) {                # if there are 2 unique xs and ys proceed
      my $minx = min(@xs);                              # find smallest x
      my $miny = min(@ys);                              # find smallest y
      my $maxx = max(@xs);                              # find biggest x
      my $maxy = max(@ys);                              # find biggest y

      my $x = $minx;                                    # set smallest x to x
      my $y = $miny;                                    # set smallest y to y
      my $width = $maxx - $minx;                        # set width by subtrating smallest x from largest
      my $height = $maxy - $miny;                       # set height by subtrating smallest y from largest

      my @no_points_attributes = grep { !/points/ } @attributes;  # get all the attributes that were not points
      my $no_points = join(' ', @no_points_attributes);           # put non-point attributes into a string

      $new_value = qq(<rect x="$x" y="$y" width="$width" height="$height" $no_points />); # the complete new <rect>
    }
    else {
      $new_value = $line; # is the original line, since it is not a rectangle or square.
    }
  }
  else {
    $new_value = $line; # is the original line, since it is not a rectangle or square.
  }

  return $new_value;
}

=pod

=encoding utf8

=head1 NAME

B<SVG::MakeRect> is a tool to convert four-sided polygons in SVG files into rectangles.

=head1 SYNOPSIS

  use SVG::MakeRect qw(make_rect);

  # When the polygon has four points.

  my $new_shape = make_rect(qq(<polygon id="polygon1" points="168,-129.6 239,-129.6 239,-165.6 168,-165.6 " />));

  # <rect x="168" y="-165.6" width="71" height="36" id="polygon1" />

  # When the polygon has five points but only four unique points.

  my $new_shape = make_rect(qq(<polygon fill="#ccccff" stroke="#000000" points="185,-165.6 59,-165.6 59,-129.6 185,-129.6 185,-165.6"/>));

  # <rect x="59" y="-165.6" width="126" height="36" fill="#ccccff" stroke="#000000" />

  # When the polygon is not a rectangle.

  my $new_shape = make_rect(qq(<polygon id="polygon087" points="41.2,-227 -4.8,-227 -27.5,-202.5 -4.8,-178 41.2,-178 64.2,-202.5 " />));

  # <polygon id="polygon087" points="41.2,-227 -4.8,-227 -27.5,-202.5 -4.8,-178 41.2,-178 64.2,-202.5 " />

=head1 DESCRIPTION

c<make_rect> returns a rectangle svg element built from a polygon element with four unique points. It will not convert polygons with fewer or more unique points than four. It will not convert any polygon that has more than two unique xs or ys, so it should not convert trapeziums, trapezoids, parallelograms, rhombi, kites, other complex four sided polygons, or irregular four sided polygons.

All attributes that were not points will be moved to the end of the attribute list.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;