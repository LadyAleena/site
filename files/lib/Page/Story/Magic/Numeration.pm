package Page::Story::Magic::Numeration;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
use Math::BigInt;

use Page::HTML qw(table);
use Number::Format::Pretty qw(commify);

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

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::Numeration> exports the doc and line magic for my Numeration scale page.


=head1 VERSION

This document describes Page::Story::Magic::Numeration version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::Numeration depends on Page::HTML, Number::Format::Pretty, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
