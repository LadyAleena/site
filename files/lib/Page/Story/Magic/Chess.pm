package Page::Story::Magic::Chess;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Page::Data qw(make_array);
use Page::HTML qw(definition_list figure object);
use Page::Line qw(line);
use Page::File qw(file_directory);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(chess_magic);

sub chess_magic {
  my $magic;

  $magic->{'pieces'} = sub {
    my $definition_list = make_array( 'file' => ['Miscellany', 'royal_chess.txt'], 'headings' => ['term', 'definition'] );
    definition_list(5, $definition_list)
  };
  $magic->{board} = sub {
    my $directory = file_directory('Miscellany', 'images');
    my $link = "$directory/royal_chess_text.svg";
    figure(6, sub {
      line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
    }, { 'id' => 'royal_chess_board', 'class' => 'svg_group centered'  });
  };

  return $magic;
}

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::Chess> exports the doc and line magic for my Chess variations page.

=head1 VERSION

This document describes Page::Story::Magic::Chess version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::FamilyTree depends on Page::Data, Page::HTML, Page::Line, Page::File, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
