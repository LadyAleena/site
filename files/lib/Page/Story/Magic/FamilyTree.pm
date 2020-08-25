package Page::Story::Magic::FamilyTree;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Page::Line qw(line);
use Page::HTML qw(object figure anchor);
use Page::File qw(file_list);
use Util::Convert qw(textify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(family_tree_magic);

sub family_tree_magic {
  my $trees_dir = shift;
  my $magic;

  my @trees_list = file_list($trees_dir);
  for my $tree_file (@trees_list) {
    my $link = "$trees_dir/$tree_file";
    my $class = 'svg_group';
    my $text = textify($tree_file);
    my ($family, $source) = split(/ /, $text, 2);
    my $title = $family && $source ? "The $family family from $source." : $text;

    $magic->{$text} = sub {
      figure(6, sub {
        line(7, anchor( '', { 'href' => $link, 'target' => 'new' }));
        line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
      }, { 'class' => $class, 'title' => $title });
    };
  }

  return $magic;
}

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::FamilyTree> exports the doc and line magic for my Fictional family tree pages.

=head1 VERSION

This document describes Page::Story::Magic::FamilyTree version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::FamilyTree depends on Page::HTML, Page::Line, Page::File, Util::Convert, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
