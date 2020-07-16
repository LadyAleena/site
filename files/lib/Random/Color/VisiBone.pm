package Random::Color::VisiBone;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(random_VisiBone_color);

use Fancy::Rand qw(fancy_rand);

my %VisiBone_colors = (
  'brightness' => [qw(white pale light medium dark obscure black)],
  'vividness' => [qw(vivid hard faded dull weak grey)],
  'hue' => [qw(red orange yellow spring green teal cyan azure blue violet magenta pink)],
);

sub random_VisiBone_color_attribute {
  my ($user_VB_color, $user_additions) = @_;
  my $VB_color = fancy_rand(\%VisiBone_colors, $user_VB_color, { caller => 'random_VisiBone_color', additions => $user_additions ? $user_additions : undef });
  return $VB_color;
}

sub random_VisiBone_color {
  my $brightness = random_VisiBone_color_attribute('brightness');
  my $vividness = random_VisiBone_color_attribute('vividness');
  my $hue = random_VisiBone_color_attribute('hue');

  my $color;
  if ($brightness eq 'white'||$brightness eq 'black') {
    $color = $brightness;
  }
  elsif ($vividness eq 'grey') {
    $color = "$brightness $vividness";
  }
  else {
    $color = "$brightness $vividness $hue";
  }

  return $color;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Color::VisiBone> selects random colors based on the Web Designer's Color Reference Poster by L<VisiBone|http://www.visibone.com/color/poster4x.html>.

=head1 SYNOPSIS

  use Random::Color::VisiBone qw(random_VisiBone_color);

=head1 DEPENDENCIES

Random::Color::VisiBone depends on L<Fancy::Rand>.

=head1 AUTHOR

Lady Aleena

=cut

1;