package Page::Story::Magic::Numeration;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
use Math::BigInt;

use Page::HTML qw(table);
use Page::Number::Pretty qw(commify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(numeration_magic);

sub numeration_magic {
  my $magic;

  $magic->{'scale'} = sub {
    my @scale = qw(m d tr tetr pent hex hept oct enn dec hendec dodec triskaidec tetrakaidec pentakaidec hexakaidec heptakaidec octokaidec ennaekaidec icosadec icosihen icosid icositr icositetr icosipent icosihex icosihept icosioct icosienn);
    my $i = 1;
    my @rows;
    for (@scale) {
      my $number = commify(Math::BigInt->new(10**(3*$i++)));
      push @rows, ["${_}illion", $number];
    }

    table(4, {
      'id' => 'numeration_scale_data',
      'class' => 'number',
      'rows' => [
        ['header', [['Name', 'Number']]],
        ['data', \@rows]
      ],
    })
  };

  return $magic;
}

# Version 1.0
# Depends on Page::HTML, Page::Number::Pretty, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;