package Page::Story::Magic::Programs;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(program_magic);

use Util::Data qw(make_hash);

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

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;