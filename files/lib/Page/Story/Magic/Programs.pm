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

# Version 1.0
# Depends on Page::Data and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;