package Page::Story::Magic::Numeration;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(numeration_magic);

use HTML::Elements qw(table);
use Util::Number   qw(commify);

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

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
