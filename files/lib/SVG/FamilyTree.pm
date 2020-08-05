package SVG::FamilyTree;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(tree_paths tree_rect);

use Fancy::Join::Defined qw(join_defined);
use SVG::Box::Width      qw(name_width);
use Util::Convert        qw(idify);

use SVG ();

sub make_ids {
  my $in = shift;
  (my $no_space = $in) =~ s/\s//g;
  my $id = idify($no_space);
  return $id;
}

sub family_y {
  my ($gen, $num_parents) = @_;

  my $multiplier = $gen - 1;
  my $modifier   = $num_parents == 2 ? 0 : $num_parents == 1 ? 18 : 38;
  my $family_y = (-18 + (-76 * $multiplier)) + $modifier;

  return $family_y;
}

sub tree_paths {
  my ($svg, $input) = @_;

  # Start the family group

  my $points = [ split(/; /, $input) ];
  my $data;
  for my $point (@$points) {
    my ($key, $value) = split(/\=/, $point);
    $data->{$key} = $value;
  }
  my $family   = $data->{family};
  my $gen      = $data->{gen};
  my $mother   = $data->{mother};
  my $father   = $data->{father};
  my $children = $data->{children};

  if ( $gen == 1 && $children ) {
    die "Generation 1 families do not have children, you might want generation 2. tree-paths.pl died$!";
  }
  my $Yyy     = $mother ? substr $mother, 0, 3 : undef;
  my $Xxx     = $father ? substr $father, 0, 3 : undef;

  my $moth_id = $mother ? make_ids($mother) : undef;
  my $fath_id = $father ? make_ids($father) : undef;

  my $couple  = join_defined(' and ', ($mother, $father));

  my $num_parents = ($mother && $father) ? 2 :
                    ($mother || $father) ? 1 :
                    0;

  my $rel_id  = $num_parents == 2 ? "$Yyy$Xxx" :
                $mother ? $moth_id :
                $father ? $fath_id :
                $family ? $family :
                undef;

  my $rel     = $data->{rel} // undef;
  my $abb_rel = $rel ? substr $rel, 0, 1 : undef;

  my $couple_id = "$abb_rel$rel_id";

  my $child_list  = $children ? [ split(/, /, $children) ] : undef;
  my $child_ids   = $children ? [ map { make_ids($_) } @$child_list ] : undef;
  my $child_count = $children ? @$child_list : 0;

  my $family_y = family_y($gen, $num_parents);

  my $family_group;
  my $child_group;

  # Start the paths of relationship if both parents are known

  if ( $num_parents == 2 ) {
    $family_group   = $svg->group( id => '', class => $rel, transform => "translate(79, $family_y)" );
    $family_group->tag('title')->cdata(ucfirst "$rel of $couple");
    $family_group->tag('path', d => 'm 0,0 h -19', id => "$couple_id-$moth_id");
    $family_group->tag('path', d => 'm 0,0 h  19', id => "$couple_id-$fath_id");
  }

  # End the paths of relationship if both parents are known
  # Start the group for the children

  if ( $child_count > 0 ) {
    my $id_prefix = $num_parents > 0 ? "c$rel_id" : "sib$rel_id";

    # Start section determining if children group stands alone.
    if ( $num_parents == 2 ) {
      $child_group = $family_group->group( id => "$family-children", class => 'child' );
    }
    else {
      $child_group = $svg->group( id => "$family-siblings", class => 'child', transform => "translate(30, $family_y)" );
    }

    # End section determining if children group stands alone.
    # Start paths for children
    # Start path for one child

    if ( $child_count == 1 ) {
      $child_group->tag('title')->cdata("$child_list->[0], child of $couple");
      $child_group->tag('path', d => 'm 0,0 v  58', id => "$couple_id-$child_ids->[0]");
    }

    # End path for one child
    # Start group for multiple children

    else {
      my $child_title = $num_parents > 0 ? "Children of $couple" : "$family siblings";

      my $base_h  = -40;
      my $start_h = $base_h + (( $#$child_ids - 1 ) * -40);
      my $start_v = $num_parents == 2 ? 38 :
                    $num_parents == 1 ? 20 :
                    0;

      $child_group->tag('title')->cdata($child_title);
      $child_group->tag('path', d => "m 0,0  v  $start_v", id => "$couple_id-$id_prefix") if $num_parents > 0;
      for my $num (0..$#$child_ids) {
        $child_group->tag('path', d => "m 0,$start_v h $start_h v 20", id => "$id_prefix-$child_ids->[$num]");
        $start_h += 80;
      }

      $child_group->tag('circle', cx => '0', cy => $start_v, r => "1.5", id => "$id_prefix");

    # End group for multiple children
    }
  }

  # End the group for the children
  # Start the circle of relationship of parents if both are known
  ## This circle had to come last.
  ## It covers the converging ends of the paths between the parents and children.

  if ( $num_parents == 2 ) {
    $family_group->tag('circle', cx => '0', cy => '0', r => "1.5", id => "$abb_rel$rel_id");
  }
  # End the circle of relationship of parents if both are known
  # End the family group

  my $text = $num_parents == 2 ? $family_group->xmlify : $child_group->xmlify;
  return $text;
}

sub tree_rect {
  my ($svg, $person) = @_;
  my ($text, $class, $gen) = split(/, /, $person);
  my @text_parts = split(/ (?!.\.)/, $text, 3);
  my $group_id = make_ids($text);
  my $base_y = -36;
  my $gen_y = $base_y + ( ($gen - 1) * -76 );
     $gen_y += -2 if @text_parts == 3;
  my $rect_width = name_width($text);
  my $rect_height = @text_parts == 3 ? 40 : 36;
  my $text_x = $rect_width / 2;
  my $text_y = @text_parts == 3 ? 8 : @text_parts == 2 ? 12 : 18;

  my $character = $svg->group( id => $group_id, class => $class, transform => "translate(0, $gen_y)" );
     $character->tag('title')->cdata($text);
     $character->tag('rect', x => 0, y => 0, width => $rect_width, height => $rect_height);

  for my $text_part (@text_parts) {
     my $text_class = $text_part =~ /\(/ ? 'nickname' : '';
     $character->text( x=> $text_x, y => $text_y, class => $text_class )->cdata($text_part);
     $text_y += 12;
  }

  return $character->xmlify;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;