package SVG::Crossover;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(movie_box spinoffs crossover to_crossover);

use SVG ();

use Util::Convert qw(idify textify);
use SVG::Box::Width qw(title_width);

sub title_id {
  my $title = shift;
     $title =~ s/\b(the|a|an|and)\b //ig;
     $title =~ s/ Show//g;
     $title =~ s/://g;
     $title =~ s/\.//g;
  return idify($title);
}

sub movie_box {
  my ($svg, $movie, $x, $y) = @_;

  $x = $x // 0;
  $y = $y // 0;

  my $id    = title_id($movie);
  my $title = textify($movie, { parens => 'keep' });
  my $movie_group = $svg->group( id => $id, transform => "translate($x,$y)");
     $movie_group->tag('title', id => "${id}_title")->cdata($title);
     $movie_group->tag('rect', id => "${id}_box", x => 0, y => 0, width => title_width($movie), height => 28);
     $title =~ s/(.+) (\((.+)\))/$1 <tspan>$2<\/tspan>/; # I do not want the tspan in the title above.
     $movie_group->text( id => "${id}_text", x => 6, y => 14)->cdata_noxmlesc($title);
  my $text = $movie_group->xmlify;
  return $text;
}

sub spinoffs {
  my ($svg, $input) = @_;

  my @movies   = split(/; /, $input);
  my $top      = shift @movies;
  my $first    = shift @movies;
  my $top_id   = title_id($top);
  my $first_id = title_id($first);


  my $main_group = $svg->group( id => "${top_id}_franchise", transform => 'translate(0,0)' );
     $main_group->tag('title', id => "${top_id}_franchise_title")->cdata($top);

  if (@movies) {
    my $spinoff_group = $main_group->group( id => "${top_id}_spinoff_group", class => 'spinoff', transform => "translate(13)" );
       $spinoff_group->tag('title', id => "${top_id}_spinoff_group_title")->cdata("The $top spinoffs");
       $spinoff_group->tag('path', d => "m 0, 30 v 24 h 15", id => "${top_id}_to_${first_id}");
      my $path_y = 55;
      for my $movie (@movies) {
        my $movie_id = title_id($movie);
        $spinoff_group->tag('path', d => "m 0, $path_y v 39 h 15", id => "${top_id}_to_${movie_id}" );
        $path_y += 40;
      }
  }
  else {
    $main_group->tag('path', d => "m 13, 30 v 24 h 15", class=> 'spinoff', id => "${top_id}_to_${first_id}");
  }

  unshift @movies, $first;
  movie_box($main_group, $top);
  my $y = 40;
  for my $movie (@movies) {
    movie_box($main_group, $movie, 30, $y);
    $y += 40;
  }

  my $text = $main_group->xmlify;
  return $text;
}

sub crossover {
  my ($svg, $input) = @_;

  my ($class, $top, $crossovers) = split(/; /, $input, 3);
  my $top_id = title_id($top);
  my @movies = map { title_id($_) } split(/; /, $crossovers);
  my $first  = shift @movies;

  my $main_group;
  if (@movies) {
    $main_group = $svg->group( id => "${top_id}_crossovers", class => $class, transform => "translate(0,14)" );
    $main_group->tag('title', id => "${top_id}_crossovers_title")->cdata("$top crossovers");
    $main_group->tag('path', d => 'm 0,0 h 15', id => "${top_id}_to");
    my $crossover_group = $main_group->group( transform => "translate(15,0)");
       $crossover_group->tag('path', d => 'm 0,0 h 15', id => "${top_id}_to_${first}");
      my $vertical = 40;
      for my $movie (@movies) {
        $crossover_group->tag('path', d => "m 0,0 v $vertical h 15", id => "${top_id}_to_${movie}");
        $vertical += 40;
      }
  }
  else {
    $main_group = $svg->tag('path', d => 'm 0,14 h 24', class => $class, id => "${top_id}_to_${first}");
  }

  my $text = $main_group->xmlify;
  return $text;
}

sub to_crossover {
  my ($svg, $input) = @_;

  my @movies = map { title_id($_) } split(/; /, $input);
  my $class = shift @movies;
  my $top   = shift @movies;
  my $last  = pop @movies;

  my $main_group = $svg->group( id => "${top}_crossovers", class => $class, transform => "translate()" );
     $main_group->tag('title', id => "${top}_crossovers_title")->cdata("$top crossovers");

  my $crossover_group = $main_group->group( transform => "translate(-15,0)");
    my $vertical = -40 * scalar(@movies);
    for my $movie (@movies) {
      $crossover_group->tag('path', d => "m -45,0 v $vertical h 15", id => "${movie}_to_${top}");
      $vertical += 40;
    }
     $crossover_group->tag('path', d => 'm -45,0 h -15', id => "${last}_to_${top}");

     $main_group->tag('path', d => 'm 0,0 h -15', id => "to_${top}");

  my $text = $main_group->xmlify;
  return $text;
}

1;