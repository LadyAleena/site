package Xanth::Location;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Open    qw(fancy_open);
use Fancy::Join    qw(join_defined grammatical_join);
use HTML::Elements qw(anchor);
use Util::Convert  qw(textify idify searchify);
use Util::Data     qw(data_file);
use Xanth::Util    qw(get_article);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(section_link location_link get_locations);

my @moons_list = fancy_open(data_file('Fandom/Xanth', 'moons.txt'));
my $moon_list = join('|', @moons_list);

my @worlds_list = fancy_open(data_file('Fandom/Xanth', 'worlds.txt'));
my $world_list = join('|', @worlds_list);

sub section_link {
  my ($main, $section) = @_;

  my $text    = textify(join(', ', reverse split(/, /,$section)));
  my $id      = idify($section);
  my $link    = anchor($text, { href => "Characters.pl?location=$main#$id" });
  my $article = $main ne 'Mundania' ? get_article($section) : undef;
  my $section_text = join_defined(' ', ($article, $link));

  return $section_text;
}

sub location_link {
  my ($main, $section) = @_;

  my $text    = textify($main);
  my $search  = searchify($main);
  my $link    = anchor($text, { href => "Characters.pl?location=$search" });
  my $article = $main ne 'Mundania' ? get_article($main) : undef;
  my $main_text    = join_defined(' ', ($article, $link));
  my $section_text = $section ? section_link($search, $section) : undef;
  my $prep         = $main =~ /^($moon_list)$/ ? 'on' : 'in';
  my $place_text   = join_defined(" $prep ", ($section_text, $main_text));

  return $place_text;
}

sub get_locations {
  my $in_places = shift;
  my @out_places;
  for ( my $place_no = 0; $place_no < @$in_places; $place_no++ ) {
    my $curr_place = $in_places->[$place_no];
    my $next_place = $in_places->[$place_no + 1];
    if ($next_place && $curr_place->[0] eq $next_place->[0] && $curr_place->[1] ) {
      push @out_places, section_link($curr_place->[0], $curr_place->[1]);
    }
    else {
      push @out_places, location_link($curr_place->[0], $curr_place->[1]);
    }
  }
  my $place_text = grammatical_join('then', @out_places);
  return $place_text;
}

=pod

=encoding utf8

=head1 VERSION

This document describes Xanth::Location version 1.0.

=head1 DEPENDENCIES

Xanth::Location depends on L<Fancy::Open>, L<Fancy::Join>, HTML::Elements, Util::Convert, Util::Data, Xanth::Util, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;