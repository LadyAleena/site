package Page::Story::Magic::RolePlaying;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
use Lingua::EN::Inflect qw(PL_N);

use Page::Data qw(make_array);
use Page::File qw(file_directory);
use Page::HTML qw(definition_list object figure img);
use Page::Line qw(line);
use Util::Convert qw(searchify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(
  Afma_flag_magic
  alignment_magic
  equipment_magic
  location_magic
  monster_magic
);

sub Afma_flag_magic {
  my $magic;
  $magic->{'flag'} = sub {
    line(6, img({ 'src' => '../../../files/images/flag.jpg', 'alt' => 'Aleenia flag', 'title' => 'Flag of Aleenia', 'class' => 'right' }))
  };
  return $magic;
}

sub alignment_magic {
  my $magic;
  $magic->{'alignment chart'} = sub {
    my $directory = file_directory('Role_playing', 'images');
    my $exp_align_link = "$directory/Expanded_alignments_scores.svg";
    figure(6, sub {
      line(7, object( '', { 'data' => $exp_align_link, 'type' => 'image/svg+xml', 'title' => 'Expanded Alignment Chart' })); # object used instead of img, b/c img won't render svg properly
    }, { 'id' => 'alignment_chart', 'class' => 'svg_group centered' });
  };
  return $magic;
}

sub equipment_magic {
  my $magic;
  $magic->{'equipment'} = sub {
    my @def_headings = ('cost', 'weight', 'items included');
    my $definition_list = make_array( 'file' => ['Role_playing/Reference_tables', 'Equipment_kits.txt'], 'headings' => ['term', @def_headings] );
    definition_list(4, $definition_list, { 'headings' => \@def_headings, 'span class' => 'definition_heading' })
  };
  return $magic;
}

sub location_magic {
  my $magic;
  # Start Olakeen holidays
  $magic->{'Holidays'} = sub {
    my $directory = file_directory('Role_playing/Locations/Olakeen');
    my $Olakeen_holidays = make_array( 'file' => "$directory/Holidays.txt", 'headings' => [qw(term date celebrations)]);
    for my $bare_term (@{$Olakeen_holidays}) {
      my $term = $bare_term->{'term'};
      $bare_term->{'term'} = [$term, { 'class' => 'holiday' }];
    }
    definition_list(5, $Olakeen_holidays, { 'headings' => [qw(date celebrations)], 'span class' => 'definition_heading' } );
  };
  # End Olakeen holidays
  return $magic;
}

sub monster_magic {
  my $magic;
  for (qw(twarg throglin tralg trobold gobpry zarden), 'dark centaur') {
    my $search = searchify(ucfirst $_);
    my $text   = PL_N($_);
    $magic->{$text} = qq(A<$text|href="../Monsters/index.pl?monster=$search">);
  }
  return $magic;
}

# Version 1.0
# Depends on Page::Data, Page::File, Page::HTML, Page::Line, Util::Convert, and Exporter.
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;