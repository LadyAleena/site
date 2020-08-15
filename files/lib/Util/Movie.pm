package Util::Movie;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(movie series franchise genre sources movie_option start_year end_year
  display_movie display_simple_movie display_option print_franchise print_series print_movie
  textify_movie get_genre get_media movies_beginning);

use File::Spec;
use Lingua::EN::Inflect qw(A PL_N NUM NO NUMWORDS inflect);
use List::Util qw(min max);

use HTML::Elements qw(footer section nav heading paragraph list span anchor);

use Fancy::Join::Defined     qw(join_defined);
use Fancy::Join::Grammatical qw(grammatical_join);

use Util::Columns       qw(number_of_columns);
use Util::Convert       qw(filify textify idify searchify);
use Util::Data          qw(data_file make_hash get_data);
use Util::ExternalLinks qw(external_links);
use Util::Path          qw(base_path);
use Util::People        qw(people_list);

my $movies     = make_hash( 'file' => ['Movies','movies.txt'],     'headings' => ['title','start year','end year',qw(media Wikipedia allmovie IMDb TV.com genre+ source company)] );
my $seriess    = make_hash( 'file' => ['Movies','series.txt'],     'headings' => [qw(title Wikipedia allmovie programs+), 'just like'] );
# my $franchises = make_hash( 'file' => ['Movies','franchises.txt'], 'headings' => [qw(title Wikipedia allmovie programs+), 'just like'] );
my $crossovers = make_hash( 'file' => ['Movies','crossovers.txt'], 'headings' => [qw(title crossovers+)] );
my @crossover_headings = qw(episode season movie series);
my @episode_headings   = qw(title crossovers);

# for movies by...
my $genres;
my $sources;

# for the select options for the series list
my $series_select;

my $current_year = (localtime())[5] + 1900;
# my ($first,$last);

for my $movie (values %$movies) {
  my $title = $movie->{'title'};

=years and format no longer used
  # populating the years option
  my $start = start_year($movie);
  my $end   = end_year($movie);

  if (!defined($first) || $first > $start) {
    $first = $start;
  }

  if (!defined($last) || $last < $end) {
    $last = $end;
  }

  # splitting format (I own), also adding what seasons I own of TV series.
  my @formats = $movie->{'format'} ? @{$movie->{'format'}} : ();
  $movie->{'format'} = undef;
  for my $r_format (@formats) {
    my ($format,$r_seasons) = split(/:/,$r_format);
    my $seasons = [eval($r_seasons)] if $r_seasons;
    $movie->{'format'}{$format} = $seasons ? scalar(@$seasons) : 1;
    if ($movie->{'media'} eq 'tv' && $seasons) {
      for my $season (@$seasons) {
        my $season_text = sprintf('season %02s',$season);
        $movie->{'seasons'}{$season_text}{'own'} = $format;
      }
    }
  }
  if (@formats) {
    my ($biggest) = sort { $movie->{'format'}{$b} <=> $movie->{'format'}{$a}  } keys %{$movie->{'format'}};
    $movie->{'format'}{'primary'} = $biggest;
  }
=cut

  # splitting media, $parts is used later.
  my ($media, $parts) = split(/:/, $movie->{'media'});
  $movie->{'media'} = $media;

  # splitting genre
  #die "$movie->{'title'} has no genre!" if !$movie->{'genre'};
  my @genres = $movie->{'genre'} ? @{$movie->{'genre'}} : ();
  $movie->{'genre'} = undef;
  for my $r_genre (@genres) {
    my ($genre, $theme) = split(/:/, $r_genre);
    my @themes = $theme ? split(/,/, $theme) : ('main');
    push @{$movie->{'genre'}}, $genre if $genre ne 'monster';
    push @{$movie->{'theme'}}, @themes if $theme;
    push @{$genres->{$genre}{$_}}, $title for @themes; # populating $genres
  }

  # populating $sources
  my $source  = $movie->{'source'}  ? $movie->{'source'} : undef;
  my $company = $movie->{'company'} ? $movie->{'company'} : undef;
  if ($source && $company) {
    push @{$sources->{$source}{$company}}, $title;
  }
  elsif ($source) {
    push @{$sources->{$source}{'main'}}, $title;
  }

  # adding to the counts in the movie for miniseries
  $movie->{'counts'}{'episode'} = $parts if $parts;

  # adding to the counts in the movie for award shows
  if (grep($_ =~ 'award show', @{$movie->{'genre'}})) {
    my $episodes = ($current_year - $movie->{'start year'}) + 1;
    $movie->{'counts'}{'episode'} = $episodes;
  }

  # adding crossovers from %crossovers
  if ($crossovers->{$title}) {
    my @r_crossovers = @{$crossovers->{$title}{'crossovers'}};
    for my $r_crossover (@r_crossovers) {
      my %crosses;
      @crosses{@crossover_headings} = split(/\//,$r_crossover);
      push @{$movie->{'crossovers'}}, \%crosses;
    }
  }

  next if ($movie->{'media'} ne 'tv' || grep($_ =~ 'show', @{$movie->{'genre'}}));
  # adding TV episodes
  my $show_file = data_file('Movies/Episode_lists', filify($title).".txt");
  my $show_fh;
  if (-f $show_file) {
    open($show_fh, '<', $show_file) || die "Can not open $show_file $!";
  }
  else {
    next;
  }
  my @data = <$show_fh>;
  chomp @data;
  close($show_fh);

  my $season;
  my $inc;
  for my $line (@data) {
    if ($line eq '.') {
      $inc++;
      $movie->{'counts'}{'season'}++;
      my $season_num = sprintf "%02s", $inc;
      $season = "season $season_num";
      $movie->{'seasons'}{$season}{'title'} = 'Season '.NUMWORDS($inc);
    }
    else {
      $movie->{'counts'}{'episode'}++;
      $movie->{'seasons'}{$season}{'counts'}{'episode'}++;
      my @episode_values = split(/\|/, $line);
      my %episode;
      @episode{@episode_headings} = @episode_values;

      if ($episode{'crossovers'}) {
        # splitting into array here b/c make_hash was not used
        my @r_crosses = split(/; ?/, $episode{'crossovers'});
        $episode{'crossovers'} = undef;
        for my $cross (@r_crosses) {
          my %crosses;
          @crosses{@crossover_headings} = map { length($_) ? $_ : undef } split(/\//, $cross);
          push @{$episode{'crossovers'}}, \%crosses;
        }
      }

      push @{$movie->{'seasons'}{$season}{'episodes'}}, \%episode;
    }
  }

  # adding to the series select list, it may be deleted later if it is in a series below.
  $series_select->{$title} = 'single';
}

for my $sseries (values %$seriess) {
  my $title = $sseries->{'title'};

  my @start_years;
  my @end_years;

  for my $program (@{$sseries->{'programs'}}) {
    $movies->{$program}{'series'}{$title} = scalar @{$sseries->{'programs'}} if $movies->{$program};

    my $movie = movie($program);
    push @start_years, start_year($movie);
    push @end_years,   end_year($movie);

    my $movie_media = $movie->{'media'} || '';
       $movie_media =~ s/tv film/film/ if $movie->{'media'};
    $sseries->{'counts'}{$movie_media}++;
    my $movie_counts = $movie->{'counts'};
    if ($movie_counts) {
      for my $type (qw(season episode)) {
        $sseries->{'counts'}{$type} += $movie_counts->{$type} if $movie_counts->{$type};
      }
    }

    # I put all TV series in $series_select. If they are in a larger series, I don't want them listed separately.
    delete $series_select->{$program} if $series_select->{$program} && $movies->{$program}{'media'} =~ /tv/;
  }

  $sseries->{'start year'} = min(@start_years);
  $sseries->{'end year'} = max(@end_years);

  # adding crossovers from %crossovers
  if ($crossovers->{$title} && !$movies->{$title}) {
    my @r_crossovers = @{$crossovers->{$title}{'crossovers'}};
    for my $r_crossover (@r_crossovers) {
      my %crosses;
      @crosses{@crossover_headings} = split(/\//,$r_crossover);
      push @{$sseries->{'crossovers'}}, \%crosses;
    }
  }

  $series_select->{$title} = 'series';
}

=not in use yet

  for my $franchise (values %$franchises) {
    my $title = $franchise->{'title'};

    my @start_years;
    my @end_years;

    for my $program (@{$franchise->{'programs'}}) {
      if ($seriess->{$program}) {
        $seriess->{$program}{'franchise'} = $title;

        my $fseries = series($program);
        push @start_years, start_year($fseries);
        push @end_years,   end_year($fseries);

        $franchise->{'counts'}{'series'}++;
        for my $media (keys %{$fseries->{'counts'}}) {
          $franchise->{'counts'}{$media} += $fseries->{'counts'}{$media};
        }
      }
      elsif ($movies->{$program}) {
        $movies->{$program}{'franchise'} = $title;

        my $movie = movie($program);
        push @start_years, start_year($movie);
        push @end_years,   end_year($movie);

        my $movie_media = $movie->{'media'};
        $franchise->{'counts'}{$movie_media}++;
        my $movie_counts = $movie->{'counts'};
        if ($movie_counts) {
          for my $type ('season','episode') {
            $franchise->{'counts'}{$type} += $movie_counts->{$type} if $movie_counts->{$type};
          }
        }
      }
    }

    $franchise->{'start year'} = min(@start_years);
    $franchise->{'end year'} = max(@end_years);
  }

=cut

my $options = {
  'media'  => [qw(film miniseries tv), 'tv film'],
  'genre'  => [sort keys %$genres],
  'source' => ['book', 'novel', 'short story', 'fairy tale', qw(play musical radio comic cartoon game toy)],
  'series' => $series_select,       # is now separate from the main list
#  'year'   => [$first..$last],     # users now enter a year string
#  'format' => [qw(vhs dvd bd dg)], # users probably don't care if I own it and is no longer stored
};

# returns a single option, the options 'keys', or all options 'data'
sub movie_option {
  my ($in, $caller) = @_;
  get_data($options, $in, $caller);
}

# returns an array ref with certain options munged.
sub display_option {
  my ($select, $option) = @_;
  my $display_option = $option;
     $display_option =~ s/^tv/television/;
  return [ucfirst $display_option, { 'value' => $option }];

=no longer in use

  if ($select eq 'media') {
    $display_option = $option eq 'tv' ? uc($option) : $option;
  }
  elsif ($select eq 'format') {
    $option_display = uc($option);
  }
  else {
    $display_option = $option;
  }

=cut
}

sub textify_movie {
  my ($title, $use) = @_;
  my $text;
  if ($use && $use eq 'story') {
    $text = $title eq 'Alien3'            ? 'AlienSUP<3>'             :
            $title eq 'Connections2'      ? 'ConnectionsSUP<2>'       :
            $title eq 'Connections3'      ? 'ConnectionsSUP<3>'       :
            $title eq 'EUReKA'            ? 'EURSUP<e>KA'             :
            $title eq 'The Lion King 1.5' ? 'The Lion King 1&frac12;' :
            $title eq 'Scorpion'          ? '&#60;/Scorpion&#62;'     :
            $title eq 'Nip Tuck'          ? 'Nip/Tuck'                :
            textify($title);
  }
  else {
    $text = $title eq 'Alien3'            ? 'Alien<sup>3</sup>'       :
            $title eq 'Connections2'      ? 'Connections<sup>2</sup>' :
            $title eq 'Connections3'      ? 'Connections<sup>3</sup>' :
            $title eq 'EUReKA'            ? 'EUR<sup>e</sup>KA'       :
            $title eq 'The Lion King 1.5' ? 'The Lion King 1&frac12;' :
            $title eq 'Scorpion'          ? '&#60;/Scorpion&#62;'     :
            $title eq 'Nip Tuck'          ? 'Nip/Tuck'                :
            textify($title);
  }
  return $text;
}

sub get_genre {
  my ($genre_type, $opt) = @_;
  my $text = $genre_type =~ /(?<!fantas)y|show|dram|musical|police procedural|spoof|slasher|western/ ? PL_N($genre_type) :
             $opt->{'movie'} && $opt->{'movie'} =~ /^yt1/ ? "$genre_type movies" :
             $genre_type;
  return $text;
}

sub get_media {
  my $media_type = shift;
  my $text = $media_type eq 'film'    ? 'films' :
             $media_type eq 'tv'      ? 'television series' :
             $media_type eq 'tv film' ? 'television films' :
             $media_type;
  return $text;
}

sub movies_beginning {
  my $first = shift;
  my $text = $first eq '#' ? 'a number'    :
             $first eq '!' ? 'punctuation' :
             $first =~ /^\p{Alpha}/i ? uc($first) :
             undef;
  return "List of movies beginning with $text" if $text;
}

# returns a single movie, the movies 'keys', or all movies 'data'
sub movie {
  my ($in, $caller) = @_;
  get_data($movies, $in, $caller);
}

# returns a series movie, the series 'keys', or all series 'data'
sub series {
  my ($in, $caller) = @_;
  get_data($seriess, $in, $caller);
}

=not in use

  # returns a single franchise, the franchises 'keys', or all franchises 'data'
  sub franchise {
    my ($in, $caller) = @_;
    get_data($franchises, $in, $caller);
  }

=cut

# returns a single genre, the genres 'keys', or all genres 'data'
sub genre {
  my ($in, $caller) = @_;
  get_data($genres, $in, $caller);
}

# returns a single source, the sources 'keys', or all sources 'data'
sub sources {
  my ($in, $caller) = @_;
  get_data($sources, $in, $caller);
}

# The following group of subroutines all lead to display_movie with the exceptions of end_year and years_running.

# returns the 'counts' if the item.
sub counts {
  my ($movie) = @_;
  my $counts = $movie->{'counts'};
  my @counting;
  for my $media (qw(series film miniseries tv season episode)) {
    next if !$counts->{$media};
    if ($media eq 'tv') {
      push @counting,  "$counts->{$media} television series";
    }
    elsif ($media =~ /series/) {
      push @counting, "$counts->{$media} $media";
    }
    else {
      push @counting, NO($media, $counts->{$media});
    }
  }
  return join(', ', @counting);
}

# returns a numeric start year for comparisons.
sub start_year {
  my ($movie) = @_;
  my $start = ($movie->{'start year'} && $movie->{'start year'} ne 'tbd') ? $movie->{'start year'} : $current_year;
  return $start;
}

# returns a numeric end year for comparisons.
sub end_year {
  my ($movie) = @_;
  my $end = $movie->{'end year'} ? ($movie->{'end year'} eq 'tbd' ? $current_year : $movie->{'end year'}) : start_year($movie);
  return $end;
}

# returns a string with the start year to end year.
sub years_running {
  my ($movie) = @_;
  my $running  = $movie->{'start year'};
  my $end_year = end_year($movie);
     $running .= " - $end_year" if $running ne $end_year;
  return $running;
}

# returns a string with the run time of a television series.
sub run_time {
  my ($movie) = @_;

  my $run_text = undef;
  if ($movie->{'media'} eq 'tv' && $movie->{'end year'}) {
    if ($movie->{'end year'} eq 'tbd') {
      $run_text = "that is still running";
    }
    elsif (end_year($movie) - start_year($movie) > 0) {
      my $run_time = end_year($movie) - start_year($movie);
      $run_text = inflect("that ran for NUMWORDS($run_time) PL_N(year,$run_time)");
    }
  }
  return $run_text;
}

# returns a string of external links, used in display_movie and in Movies::Display
sub movie_links {
  my ($movie) = @_;
  my $title = $movie->{'title'};
  $movie->{'Google'} = searchify($title);
  my @links;
  for my $site (qw(Google Wikipedia allmovie IMDb TV.com)) {
    next if !$movie->{$site};
    my $link_page = $movie->{$site};
    push @links, [$site, $link_page, $title];
  }
  my $external_links = external_links(\@links);
  my $links_text = join("", @$external_links);
  my $link = $links_text;
  return $link;
}

# returns a string of what I felt is important about a movie.
sub about {
  my ($movie) = @_;

  my $start = grep( $_ =~ /non-fiction/, @{$movie->{'genre'}}) ? 'about' : 'with';
  my @abouts = $movie->{'theme'} ? @{$movie->{'theme'}} : undef;
  my $about = @abouts ? "$start ".grammatical_join('and', @abouts) : undef;

  return $about;
}

# returns what the movie is based on and by who.
sub basis {
  my ($movie) = @_;
  my $raw_base = join_defined(' by ', ($movie->{'source'}, $movie->{'company'}));
  my $basis = $movie->{'source'} ? "based on the $raw_base" : undef;
  return $basis;
}

# returns a string for a single crossover. The input is a hash ref.
sub crossover {
  my ($crossover) = @_;
  my $episode = $crossover->{'episode'} ? $crossover->{'episode'} : undef;
  my $season  = $crossover->{'season'}  ? $crossover->{'season'}  : undef;
  my $program = $crossover->{'movie'}   ? $crossover->{'movie'}   : undef;
  my $cseries = $crossover->{'series'}  ? $crossover->{'series'}  : undef;

  my $crossover_text = undef;
  if ($episode || $season || $program || $cseries) {
    my $season_text  = $season  ? "season $season" : undef;
    my $episode_text = $episode ? textify(qq( &ldquo;$episode&rdquo;)) : undef;
    my $search       = $cseries ? $cseries : $program ? $program : undef;
    my $id = $cseries && $seriess->{$cseries} ? [grep(defined,($program, $season_text))] :
             $program && $movies->{$program} && $season_text ? [$season_text] : undef;
    $crossover_text  = search_link($search, $id);
    $crossover_text .= $episode_text if $episode_text;
  }

  return $crossover_text;
}

# returns a string for all of the crossovers for a movie or episode.
sub crossovers {
  my ($movie) = @_;

  my @crossovers = @{$movie->{'crossovers'}};
  my @crosses = map(crossover($_),@crossovers);
  my $c_link = anchor('crossed', { 'href' => '../Fandom/Crossovers' });
  my $cross = scalar(@crosses) > 0 ? "$c_link with ".grammatical_join('and',@crosses) : undef;
  return $cross;
}

# creates a link to the series list on the index page. It is used in series_text, crossover, and elsewhere.
# Unlike most of the above functions, this one can be used to create links to series as well as movies.
sub search_link {
  my ($movie, $id) = @_;

  my $search = undef;
  my $texti  = textify_movie($movie);
  if (($seriess->{$movie} && $id) || (($movies->{$movie} && $movies->{$movie}->{'media'} eq 'tv') && $id)) {
    $search = searchify($movie, $id);
    $texti  = $movies->{$id->[0]} ? textify_movie($id->[0]) : textify_movie($movie);
  }
  elsif($seriess->{$movie} || ($movies->{$movie} && $movies->{$movie}->{'media'} eq 'tv')) {
    $search = searchify($movie);
  }

  my $text = "<i>$texti</i>";
  my $root = base_path('path');
  my $path = File::Spec->abs2rel("$root/Movies/index.pl");
  my $search_text = $search ? anchor($text, { 'href' => "$path?series=$search" }) : $text;

  return $search_text;
}

# returns a string listing all of the series in which a movie belongs with links.
sub series_text {
  my ($movie) = @_;

  my @series = $movie->{'series'} ? map(search_link($_), sort { $movie->{'series'}{$b} <=> $movie->{'series'}{$a} } keys %{$movie->{'series'}}) : ();
  my $lists_text = grammatical_join('and', @series);
  my $series_text = $lists_text ? $lists_text : undef;

  return $series_text;
}

# returns a string with the amount of parts in a miniseries w/numbers as words.
sub mini_parts {
  my ($movie) = @_;

  my $r_parts = $movie->{'counts'}{'episode'} ? $movie->{'counts'}{'episode'} : undef;
  my $parts   = $r_parts ? NUMWORDS($r_parts)."-part" : undef;

  return $parts;
}

# The preceding group of subroutines all lead to display_movie with the exceptions of end_year and years_running.

# returns a sentence or two for a movie.
# The first parameter is the individual movie hash ref,
# the second is a hash ref with the named parameters: series and crossovers.
sub display_movie {
  my ($movie, $opt) = @_;

  my $title  = $movie->{'title'};
  my $text   = !$movie->{'series'} && $movie->{'seasons'} ? anchor(textify_movie($title), { 'href' => 'index.pl?series='.searchify($title) }) :
                                                            textify_movie($title);
  my $id     = idify($title);

  my $start  = $movie->{'start year'} && $movie->{'start year'} ne 'tbd' ? $movie->{'start year'} : undef;
  my $genre  = $movie->{'genre'}                 ? join(' ', @{$movie->{'genre'}}) : undef;
  my $run    = $movie->{'media'} eq 'tv'         ? run_time($movie)    : undef;
  my $parts  = $movie->{'media'} eq 'miniseries' ? mini_parts($movie)  : undef;
  my $media  = $movie->{'media'} eq 'tv'         ? 'television series' :
               $movie->{'media'} eq 'tv film'    ? 'television film'   : $movie->{'media'};
  my $basis  = $movie->{'source'}                ? basis($movie)       : undef;
  my $about  = $movie->{'theme'}                 ? about($movie)       : undef;

  my $mseries = $opt->{'series'} ? series_text($movie) : undef;
  my $crosses = $opt->{'crossover'} && $movie->{'crossovers'} ? crossovers($movie) : undef;

  my $verb = $movie->{'start year'} eq 'tbd' ? 'might be' : $movie->{'start year'} > $current_year ? 'will be' : 'is';
  my $movie_is    = A(join_defined(' ', ($start, $parts, $genre, $media, $about, $basis, $run))).'.';
  my $series_text    = $mseries ? "It is part of the $mseries series." : undef;
  my $crossover_text = $crosses ? "It $crosses."                       : undef;
  my $movie_line  = join_defined(' ', ($movie_is, $series_text, $crossover_text));

  return span($text, { 'id' => $id, 'class' => 'title'}). " $verb $movie_line";
}

# returns the title in italics and the start year in parentheses.
sub display_simple_movie {
  my ($movie) = @_;
  my $title = textify_movie($movie->{'title'});
  my $start = $movie->{'start year'} ? $movie->{'start year'} : undef;

  my $item;
  if ($movie->{'series'}) {
    my $group;
    my @list = keys %{$movie->{'series'}};
    if (keys %{$movie->{'series'}} > 1) {
      ($group) = sort { $movie->{'series'}{$b} <=> $movie->{'series'}{$a} } keys %{$movie->{'series'}};
    }
    else {
      $group = $list[0];
    }
    $item = search_link($group, [$movie->{'title'}]);
  }
  elsif ($movie->{'seasons'}) {
    $item = search_link($movie->{'title'});
  }
  else {
    $item = "<i>$title</i>";
  }
  $item .= $start ? " ($start)" : undef;

  return $item;
}

# separates the parts out of the episode title
sub unquote_parts {
  my ($string) = @_;
  if ($string =~ m/, Part \w+$/) {
    $string =~ s/(.+?),\s(Part \w+)/&ldquo;$1&rdquo;, $2/;
    return $string;
  }
  else {
    return qq(<q>$string</q>);
  }
}

# returns the navigation link
sub nav_link {
  my $word = shift(@_);
  my $id   = idify(@_);
  my $text = textify(pop @_);

  if ($text =~ m/^season/) {
    my @season_title = split(' ', $text);
    $text = $word && $word eq 'word' ? ucfirst NUMWORDS($season_title[1]) : $season_title[1] + 0;
  }

  return anchor($text, { 'href' => "#$id" });
}

sub like {
  my ($program, $agree, $just_like) = @_;
  my $like   = $just_like && $just_like =~ /d+/ && $just_like > 1 ? NO("<i>$program</i> film", $just_like, {words_below => 10}) : "<i>$program</i> film";
  my $string = $just_like && $just_like eq 'n' ? '' : $just_like && $just_like > 0 ? "I like the first $like, the rest were included for completeness." :
               "I or my fiancé like <i>$program</i> and would like to see it when we come upon it." ;
  $string .= ' If you disagree with the inclusion of a film or program on this list, you can contact me through the email link above.' if $agree;
  return $string;
}

my $epgd = anchor('epguides',  { 'href' => 'http://epguides.com', 'target' => 'new' });
my $wkpd = anchor('Wikipedia', { 'href' => 'http://en.wikipedia.org', 'target' => 'new' });
my $eplist = "The episode lists would have been a pain to put together without $epgd or $wkpd.";

# returns episode title with any crossovers
sub tv_episode {
  my ($episode) = @_;

  my $episode_name   = textify($episode->{'title'});
  my $episode_date   = $episode->{'date'} ? "($episode->{'date'})" : undef;
  my $crossover_text = $episode->{'crossovers'} ? crossovers($episode) : undef;

  my $episode_text;
  if ($episode_name =~ m/^((|Unaired )Pilot|Un(nam|titl)ed)(|, Part \d+)$/ || $episode_name =~ m/^(?:Episode|Part) \d+$/) {
    $episode_text = $episode_name;
  }
  elsif ($episode_name =~ m/, Part \w+$/) {
    $episode_text = unquote_parts($episode_name);
  }
  elsif ($episode_name =~ m/\saka\s/) {
    my @episode_names = map(unquote_parts($_), split(/ aka /, $episode_name));
    $episode_text = join(" <small>a.k.a.</small> ", @episode_names);
  }
  else {
    $episode_text = qq(&ldquo;$episode_name&rdquo;);
  }

  return join_defined(' ', ($episode_text, $crossover_text));
}

sub tv_season {
  my ($heading, $in_season, $program, $series) = @_;
  my $movie = movie($program);
  my $local_season = $movie->{'seasons'}{$in_season};

  my $out_heading;
  my $out_counts;
  if ($heading) {
    my $season_id = $series ? idify($program, $in_season) : idify($in_season);
    my $season_text = $local_season->{title};
    my $counts_text = counts($local_season);

    $out_heading = [$heading, $season_text, { 'id' => $season_id, 'class' => 'season' }];
    $out_counts  = "($counts_text)";
  }
  my @episodes = map( tv_episode($_), @{$local_season->{'episodes'}} );
  my $out_list = ['o', \@episodes, { 'class' => 'episode_list two' }];

  return {
    'heading' => $out_heading ? $out_heading : undef,
    'counts'  => $out_counts  ? $out_counts  : undef,
    'list'    => $out_list    ? $out_list    : undef
  };
}

sub print_movie {
  my ($tab, $in_heading, $in_title, $in_series) = @_;
  die "You put in just the movie name didn't you, so I stopped" if ($tab !~ /\d+/ || $in_heading !~ /\d+/);
  my $heading = $in_heading ? $in_heading > 5 ? die('print_program heading level can not be above 5!') : $in_heading : 1;
  my $program = $in_title;

  my $movie       = movie($program, 'print_movie');
  my $movie_id    = idify($movie->{'title'});
  my $movie_text  = textify_movie($movie->{'title'});
  my $counts_text = counts($movie) ? '('.counts($movie).')'  : undef;
  my $movie_links = movie_links($movie);

  my $seasons     = $movie->{'seasons'} ? $movie->{'seasons'} : undef;
  my $movie_is    = display_movie($movie, { 'crossover' => 1 });

  my $actor_file  = 'Actors_in_'.filify($program).'.txt';
  my $people      = people_list($actor_file) ? people_list($actor_file) : undef;

  section($tab, sub {
    $tab += 2;
    paragraph($tab, $movie_links, { 'class' => 'movie_links' }) if $movie_links;
    paragraph($tab, join_defined(' ', (years_running($movie), $counts_text))) if $movie->{'media'} eq 'tv';
    paragraph($tab, $movie_is);

    if ($seasons) {
      if (scalar keys %{$seasons} > 1) {
        my $season_count = scalar keys %{$seasons};
        my $season_word  = $season_count < 10 ? 'word' : 'number';
        my @links = map(nav_link($season_word, $in_series ? $program : undef, $_), sort keys %{$seasons});
        push @links, anchor('People', { 'href' => "#actors_in_$movie_id" }) if ($people && !$in_series);
        heading($tab, $heading + 1, 'Seasons', { 'class' => 'season_list' });
        list($tab + 1, 'u', \@links, { 'class' => 'season_list' });
      }
      my $next_heading = $movie->{'counts'}{'season'} > 1 || $people ? $heading + 1 : undef;
      for my $season (sort keys %{$seasons}) {
        my $in_season = tv_season($next_heading, $season, $program, $in_series);
        heading  ($tab, @{$in_season->{'heading'}})  if $in_season->{'heading'};
        paragraph($tab + 1, $in_season->{'counts'})  if $in_season->{'counts'};
        list     ($tab + 1, @{$in_season->{'list'}}) if $in_season->{'list'};
      }
    }
    $tab -= 2;
  }, {
    'heading' => $heading  > 1 ? [2, $movie_text, { 'id' => $movie_id, 'class' => 'program' }] : undef,
  });
  if ($people && !$in_series) {
    my $cols = number_of_columns(3, scalar @$people, 1);
    section($tab, sub {
      list   ($tab + 1, 'u', $people, { 'class' => "actor_list $cols" });
    }, { 'heading' => [$heading + 1, 'People', { 'id' => "actors_in_$movie_id" }] });
  }
  if ($heading == 1) {
    footer($tab, sub {
      my $tree_page = "../Fandom/Fictional_family_trees/${movie_id}_family_trees.pl";
      if (-f $tree_page) {
        my $tree_link = anchor("Family trees", { 'href' => $tree_page });
        paragraph($tab + 1, "$tree_link have been drawn for this series.");
      }
      paragraph($tab + 1, $eplist);
    });
  }
}

sub print_series {
  my ($tab, $in_heading, $in_title) = @_;
  die "You put in just the series name didn't you, so I stopped" if ($tab !~ /\d+/ || $in_heading !~ /\d+/);
  my $heading      = $in_heading ? $in_heading > 4 ? die('print_series heading level can not be above 4!') : $in_heading : 1;
  my $series       = $in_title;

  my $local_series = series($series, 'print_series');
  my $series_id    = idify($series);
  my $series_text  = textify_movie($series);
  my $counts_text  = counts($local_series);
  my $movie_links  = movie_links($local_series);

  my $counts       = $local_series->{'counts'};
  my $programs     = $local_series->{'programs'};

  my $crossover    = $local_series->{'crossovers'} ? span($in_title, { class => 'title' }).' '.crossovers($local_series) : undef;
  my $actor_file   = 'Actors_in_'.filify($series).'.txt';
  my $people       = people_list($actor_file) ? people_list($actor_file) : undef;

  section($tab, sub {
    paragraph($tab + 1, $movie_links, { 'class' => 'movie_links'}) if $movie_links;
    paragraph($tab + 1, years_running($local_series)." ($counts_text)");
    paragraph($tab + 1, "$crossover.") if $crossover;
    if (( $counts->{'tv'} && $counts->{'tv'} > 0) || (($counts->{'film'} || 0) + ($counts->{'miniseries'} || 0)) > 10) {
      my @links = map(nav_link('word', $_), @$programs);
      push @links, anchor('Actors', { 'href' => "#actors_in_$series_id" }) if $people;
      my $cols = number_of_columns(3, scalar @links, 1);
      list($tab + 1, 'u', \@links, { 'class' => "program_list $cols" });
    }
  });

  if ($counts->{'tv'}) {
    print_movie($tab, $heading + 1, $_, $series) for @$programs;
  }
  else {
    my $section_heading = $counts->{'film'} && $counts->{'miniseries'} ? 'Films and miniseries' :
                          $counts->{'film'} ? 'Films' : $counts->{'miniseries'} ? 'Miniseries' : undef;
    section($tab, sub {
      paragraph($tab, display_movie(movie($_, 'print_series'), { 'crossover' => 1, 'links' => 1 })) for @$programs;
    }, { 'heading' => $section_heading ? [$heading + 1, $section_heading] : undef });
  }

  if ($people) {
    section($tab, sub {
      my $cols = number_of_columns(3, scalar @$people, 1);
      list($tab + 2, 'u', $people, { 'class' => "actor_list $cols" });
    }, { 'heading' => [$heading + 1 , 'Actors', { 'id' => "actors_in_$series_id" }]});
  }
  if ( $heading == 1 && $counts->{'tv'} ) {
    footer($tab, sub {
      paragraph($tab + 1, $eplist) if $counts->{'tv'};
    });
  }
}

sub print_franchise {
  my ($tab, $in_heading, $in_title) = @_;
  die "You put in just the franchise name didn't you, so I stopped" if ($tab !~ /\d+/ || $in_heading !~ /\d+/);
  my $heading         = $in_heading ? $in_heading > 3 ? die('print_franchise heading level can not be above 3!') : $in_heading : 1;
  my $franchise       = $in_title;

  my $local_franchise = franchise($franchise);
  my $counts          = $local_franchise->{'counts'};
  my $programs        = $local_franchise->{'programs'};

  my $franchise_id    = idify($franchise);
  my $franchise_text  = textify($franchise);
  my $counts_text     = counts($local_franchise);
  my $movie_links     = movie_links($local_franchise);

  $tab++;
  section($tab, sub {
    paragraph($tab, $movie_links, { 'style' => 'float: right'}) if $movie_links;
    paragraph($tab, years_running($local_franchise)." ($counts_text)");
    my @links = map(nav_link($_), @$programs);
    list($tab, 'u', \@links, { 'class' => 'program_list two' });
  });
  for my $program (@$programs) {
    if ($seriess->{$program}) {
      print_series($tab, $heading + 1, $program);
    }
    else {
      print_movie($tab, $heading + 1, $program);
    }
  }
  if ( $heading == 1 ) {
    footer($tab, sub {
      paragraph($tab + 1, like($franchise_text, 1, $local_franchise->{'just like'}), { 'class' => 'like' });
      paragraph($tab + 1, $eplist) if $counts->{'tv'};
    });
  }
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;