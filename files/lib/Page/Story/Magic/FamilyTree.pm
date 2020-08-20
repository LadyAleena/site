package Page::Story::Magic::FamilyTree;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(family_tree_magic);

use Page::Line qw(line);
use Page::HTML qw(object figure anchor);
use Page::List::File qw(file_list);
use Util::Convert qw(textify);

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

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
