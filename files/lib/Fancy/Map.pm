package Fancy::Map;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_map);

# Written with the help of GotToBTru, RonW, and toolic of Perl Monks.
# Rewritten by Tux on Perl Monks. 2020-07-09
sub fancy_map {
  my ($opt, $list) = @_;
  map { ref $_
    ? fancy_map ($opt, $_)
    : do {
        my $before = $opt->{'before'} ?     $opt->{'before'}.' ' : '';
        my $after  = $opt->{'after'}  ? ' '.$opt->{'after'}      : '';
        $before.$_.$after;
      }
  } @{$list};
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
