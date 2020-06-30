package SVG::Box::Width;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(get_width name_width title_width);

use Cairo ();

# Author Shlomi Fish <shlomif@cpan.org>
sub get_width {
  my ($string, $opt) = @_;

  my $font_face   = $opt->{'face'}   // 'arial';
  my $font_size   = $opt->{'size'}   // '16';
  my $font_style  = $opt->{'style'}  // 'normal';
  my $font_weight = $opt->{'weight'} // 'normal';

  my $surface = Cairo::ImageSurface->create( 'argb32', 2000, 1000 );
  my $cr      = Cairo::Context->create($surface);
     $cr->select_font_face( $font_face, $font_style, $font_weight );
     $cr->set_font_size($font_size);
  my $extents = $cr->text_extents($string);
  my $width = $extents->{width};

  return $width;
}

sub name_width {
  my $text = shift;
  my $font_size = $text =~ /unnamed/ ? 10 : 12;
  my @text_parts = split(/(?<!\,) (?!.\.)/, $text, 3);
  my $width = 54;
  for my $text_part (@text_parts) {
    $font_size = 10 if $text_part =~ /\(/;
    my $text_width = get_width($text_part, { 'size' => $font_size }) + 16;
       $text_width += 1 if $text_width % 2 == 1;
    $width = $text_width if $text_width > $width;
  }
  return $width;
}

sub title_width {
  my $text = shift;
  my $font_size = 16;
  my @text_parts = split(/ (?=\()/, $text, 2);
  my $width;
  for my $text_part (@text_parts) {
    my $font_style = $text_part =~ /\(/ ? 'normal' : 'italic';
    $width += get_width($text_part, { 'size' => $font_size, 'style' => $font_style });
    $font_size = 14;
  }
  $width += 5 if @text_parts == 2;
  return $width + 12;
}

1;