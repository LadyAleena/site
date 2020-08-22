package Page::Story::Magic;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(story_magic);

# Bring the magic!

sub story_magic {
  my $magic = {  };
  return $magic;
}

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic> could export the doc and line magic for various pages.

=head1 VERSION

This document describes Page::Story::Magic version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;