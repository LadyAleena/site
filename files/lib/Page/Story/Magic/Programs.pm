package Page::Story::Magic::Programs;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Page::Data qw(make_hash);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(program_magic);

sub program_magic {
  my $program_urls = make_hash( 'file' => ['Collections','programs.txt'] );
  my $magic;
  for my $link (keys %$program_urls) {
    my $link_dest = $program_urls->{$link};
    $magic->{$link} = qq(A<$link|href="http://$link_dest" target="ex_tab">);
  }

  return $magic;
}

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::Programs> exports the doc and line magic for my various pages where I need links to programs I use.

=head1 VERSION

This document describes Page::Story::Magic::Programs version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::Programs depends on Page::Data and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;