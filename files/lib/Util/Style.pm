package Util::Style;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT_OK = qw(base_stylesheets);

use File::Spec;

sub get_stylesheets {
  my ($in_styles, $css_dir, $relative_path_split, $opt) = @_;

  my $styles = $in_styles;
  while (@$relative_path_split) {
    my $var = shift @$relative_path_split;
       $var =~ s/(\.\w{2,4})$//;
    next if $var eq 'working';

    if (-f ("$css_dir/$var.css")) {
      my $new_style = File::Spec->abs2rel("$css_dir/$var.css", $opt->{'full path'});
      push @$styles, { href => $new_style, rel => 'stylesheet', type => 'text/css' };
    }

    get_stylesheets($styles, "$css_dir/$var", $relative_path_split, $opt);
  }

  return $styles;
}

sub alternate_stylesheets {
  my ($css_dir) = @_;

  opendir(my $dir, $css_dir);
  my $alternates = [
    map  {{
      href  => File::Spec->abs2rel("$css_dir/$_"),
      title => (split(/(?:\/|\.|-)/, $_))[-2],
      rel   => 'alternate stylesheet',
      type  => 'text/css'
    }}
    grep { /^alternate/ }
    File::Spec->no_upwards(readdir($dir))
  ];
  closedir($dir);

  return $alternates;
}

sub base_stylesheets {
  my ($in_styles, $css_dir, $relative_path, $opt) = @_;
  my $base_styles = [
    { href => File::Spec->abs2rel("$css_dir/normalize.css", $opt->{'full path'}), rel => 'stylesheet', type => 'text/css' },
    { href => File::Spec->abs2rel("$css_dir/main.css",      $opt->{'full path'}), rel => 'stylesheet', type => 'text/css' }
  ];
  my $styles = get_stylesheets($base_styles, $css_dir, $relative_path, $opt);
#  my $alt_styles  = alternate_stylesheets($css_dir);
  return $styles;
}

1;