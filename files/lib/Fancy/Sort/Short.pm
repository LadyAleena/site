package Fancy::Sort::Short;
use v5.16.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(short_sort);

sub short_sort {
  my ($in_a, $in_b, $type) = @_;

  # Legend:
  # s - case sensitive
  # i - case insensitive
  # a - ascending
  # d - descending
  # r - reverse (right to left)
  # n - numbers
  # l - length of value

  my %sorts;
  $sorts{$_} = sub { $_[0] cmp $_[1] } for qw(sa as);
  $sorts{$_} = sub { $_[1] cmp $_[0] } for qw(sd ds);
  $sorts{$_} = sub { fc $_[0] cmp fc $_[1] } for qw(ia ai);
  $sorts{$_} = sub { fc $_[1] cmp fc $_[0] } for qw(id di);
  $sorts{$_} = sub { $_[0] <=> $_[1] } for qw(na an);
  $sorts{$_} = sub { $_[1] <=> $_[0] } for qw(nd dn);
  $sorts{$_} = sub { reverse($_[0]) cmp reverse($_[1]) } for qw(sar sra asr ars rsa ras);
  $sorts{$_} = sub { reverse($_[1]) cmp reverse($_[0]) } for qw(sdr srd dsr drs rsd rds);
  $sorts{$_} = sub { fc reverse($_[0]) cmp fc reverse($_[1]) } for qw(iar ira air ari ria rai);
  $sorts{$_} = sub { fc reverse($_[1]) cmp fc reverse($_[0]) } for qw(idr ird dir dri rid rdi);
  $sorts{$_} = sub { reverse($_[0]) <=> reverse ($_[1]) } for qw(nar nra anr arn rna ran);
  $sorts{$_} = sub { reverse ($_[1]) <=> reverse ($_[0]) } for qw(ndr nrd dnr drn rnd rdn);
  $sorts{$_} = sub { length($_[0]) <=> length($_[1]) } for qw(la al);
  $sorts{$_} = sub { length($_[1]) <=> length($_[0]) } for qw(ld dl);

  if ($type) {
    die "$type is not supported." if !$sorts{$type};
    return $sorts{$type}->($in_a, $in_b);
  }
  else {
    die "A sort type was not selected.";
  }
}

=pod

=encoding utf8

=head1 NAME

B<Fancy::Sort::Short> returns subroutines to be used in sort.

=head1 VERSION

This document describes Fancy::Sort::Short version 1.0.

=head1 SYNOPSIS

  use Fancy::Sort::Short qw(short_sort);

=head2 String sorts

  my @colors = qw(Red orange Yellow spring Green teal Cyan azure Blue violet Magenta pink);

  my @sensitive_ascending_colors = sort { short_sort($a, $b, 'sa') } @colors;
  # returns [ 'Blue', 'Cyan', 'Green', 'Magenta', 'Red', 'Yellow', 'azure', 'orange', 'pink', 'spring', 'teal', 'violet' ]

  my @sensitive_descending_colors = sort { short_sort($a, $b, 'sd') } @colors;
  # returns [ 'violet', 'teal', 'spring', 'pink', 'orange', 'azure', 'Yellow', 'Red', 'Magenta', 'Green', 'Cyan', 'Blue' ]

  my @insensitive_ascending_colors = sort { short_sort($a, $b, 'ia') } @colors;
  # returns [ 'azure', 'Blue', 'Cyan', 'Green', 'Magenta', 'orange', 'pink', 'Red', 'spring', 'teal', 'violet', 'Yellow' ]

  my @insensitive_descending_colors = sort { short_sort($a, $b, 'id') } @colors;
  # returns [ 'Yellow', 'violet', 'teal', 'spring', 'Red', 'pink', 'orange', 'Magenta', 'Green', 'Cyan', 'Blue', 'azure' ]

  my @sensitive_ascending_reverse_colors = sort { short_sort($a, $b, 'sar') } @colors;
  # returns [ 'Magenta', 'Red', 'orange', 'azure', 'Blue', 'spring', 'pink', 'teal', 'Cyan', 'Green', 'violet', 'Yellow' ]

  my @sensitive_descending_reverse_colors = sort { short_sort($a, $b, 'sdr') } @colors;
  # returns [ 'Yellow', 'violet', 'Green', 'Cyan', 'teal', 'pink', 'spring', 'Blue', 'azure', 'orange', 'Red', 'Magenta' ]

  my @insensitive_ascending_reverse_colors = sort { short_sort($a, $b, 'iar') } @colors;
  # returns [ 'Magenta', 'Red', 'orange', 'azure', 'Blue', 'spring', 'pink', 'teal', 'Cyan', 'Green', 'violet', 'Yellow' ]

  my @insensitive_descending_reverse_colors = sort { short_sort($a, $b, 'idr') } @colors;
  # returns [ 'Yellow', 'violet', 'Green', 'Cyan', 'teal', 'pink', 'spring', 'Blue', 'azure', 'orange', 'Red', 'Magenta' ]

  my @ascending_length_colors = sort { short_sort($a, $b, 'al') } @colors;
  # returns [ 'Red', 'teal', 'Cyan', 'Blue', 'pink', 'Green', 'azure', 'orange', 'Yellow', 'spring', 'violet', 'Magenta' ]

  my @descending_length_colors = sort { short_sort($a, $b, 'dl') } @colors;
  # returns [ 'Magenta', 'orange', 'Yellow', 'spring', 'violet', 'Green', 'azure', 'teal', 'Cyan', 'Blue', 'pink', 'Red' ]

=head2 Number sorts

  my @numbers = qw(5 4 10 9 15 14 20 19 25 24 30 29);

  my @ascending_numbers = sort { short_sort($a, $b, 'na') } @numbers;
  # returns [ '4', '5', '9', '10', '14', '15', '19', '20', '24', '25', '29', '30' ]

  my @descending_numbers = sort { short_sort($a, $b, 'nd') } @numbers;
  # returns [ '30', '29', '25', '24', '20', '19', '15', '14', '10', '9', '5', '4' ]

  my @ascending_reverse_numbers = sort { short_sort($a, $b, 'nar') } @numbers;
  # returns [ '10', '20', '30', '4', '5', '9', '14', '24', '15', '25', '19', '29' ]

  my @descending_reverse_numbers = sort { short_sort($a, $b, 'ndr') } @numbers;
  # returns [ '29', '19', '25', '15', '24', '14', '9', '5', '4', '30', '20', '10' ]

=head1 DESCRIPTION

Fancy::Sort::Short returns a subroutine with the compariosn expression to be used in L<sort|https://perldoc.perl.org/functions/sort.html> based on the code entered into C<short_sort>. These codes can be entered in any order. Some of these codes are redundant but were added for completeness. C<short_sort> is not exported by default and has to be imported into your script.

  use Fancy::Sort::Short qw(short_sort);

C<short_sort> has three parameters. The first and second paremeters are C<$a> and C<$b> from C<sort>. The third parameter is the code you want to use for the sort.

  short_sort($a, $b, 'code');

It requires Perl version 5.16.0 or better.

=head2 The codes

=over

=item *

C<s> - The sort will be case I<sensitive>.

=item *

C<i> - The sort will be case I<insensitive>.

=item *

C<a> - The sort will be in I<ascending> order.

=item *

C<d> - The sort will be in I<descending> order.

=item *

C<r> - The items in the list will be I<reversed> (right to left), then sorted.

=item *

C<n> - The sort will be I<numeric>.

=item *

C<l> - The list will be sorted by the I<length> of the values.

=back

=head2 Putting the codes together

=over

=item case sensitive ascending

The codes C<sa> or C<as> can be used.

  sort { short_sorts($a, $b, 'sa') }
  sort { short_sorts($a, $b, 'as') }

=item case sensitive descending

The codes C<sd> or C<ds> can be used.

  sort { short_sorts($a, $b, 'sd') }
  sort { short_sorts($a, $b, 'ds') }

=item case insensitive ascending

The codes C<ia> or C<ai> can be used.

  sort { short_sorts($a, $b, 'ia') }
  sort { short_sorts($a, $b, 'ai') }

=item case insensitive descending

The codes C<id> or C<di> can be used.

  sort { short_sorts($a, $b, 'id') }
  sort { short_sorts($a, $b, 'di') }

=item case sensitive ascending reverse

The codes C<sar>, C<sra>, C<asr>, C<ars>, C<rsa>, or C<ras> can be used.

  sort { short_sorts($a, $b, 'sar') }
  sort { short_sorts($a, $b, 'sra') }
  sort { short_sorts($a, $b, 'asr') }
  sort { short_sorts($a, $b, 'ars') }
  sort { short_sorts($a, $b, 'rsa') }
  sort { short_sorts($a, $b, 'ras') }

=item case sensitive descending reverse

The codes C<sdr>, C<srd>, C<dsr>, C<drs>, C<rsd>, or C<rds> can be used.

  sort { short_sorts($a, $b, 'sdr') }
  sort { short_sorts($a, $b, 'srd') }
  sort { short_sorts($a, $b, 'dsr') }
  sort { short_sorts($a, $b, 'drs') }
  sort { short_sorts($a, $b, 'rsd') }
  sort { short_sorts($a, $b, 'rds') }

=item case insensitive ascending reverse

The codes C<iar>, C<ira>, C<air>, C<ari>, C<ria>, or C<rai> can be used.

  sort { short_sorts($a, $b, 'iar') }
  sort { short_sorts($a, $b, 'ira') }
  sort { short_sorts($a, $b, 'air') }
  sort { short_sorts($a, $b, 'ari') }
  sort { short_sorts($a, $b, 'ria') }
  sort { short_sorts($a, $b, 'rsi') }

=item case sensitive descending reverse

The codes C<idr>, C<ird>, C<dir>, C<dri>, C<rid>, or C<rdi> can be used.

  sort { short_sorts($a, $b, 'idr') }
  sort { short_sorts($a, $b, 'ird') }
  sort { short_sorts($a, $b, 'dir') }
  sort { short_sorts($a, $b, 'dri') }
  sort { short_sorts($a, $b, 'rid') }
  sort { short_sorts($a, $b, 'rdi') }

=item ascending length

The codes C<al> or C<la> can be used.

  sort { short_sorts($a, $b, 'al') }
  sort { short_sorts($a, $b, 'la') }

=item descending length

The codes C<dl> or C<ld> can be used.

  sort { short_sorts($a, $b, 'dl') }
  sort { short_sorts($a, $b, 'ld') }

=item numeric ascending

The codes C<na> or C<an> can be used.

  sort { short_sorts($a, $b, 'na') }
  sort { short_sorts($a, $b, 'an') }

=item numeric descending

The codes C<nd> or C<dn> can be used.

  sort { short_sorts($a, $b, 'nd') }
  sort { short_sorts($a, $b, 'dn') }

=item numeric ascending reverse

The codes C<nar>, C<nra>, C<anr>, C<arn>, C<rna>, or C<ran> can be used.

  sort { short_sorts($a, $b, 'nar') }
  sort { short_sorts($a, $b, 'nra') }
  sort { short_sorts($a, $b, 'anr') }
  sort { short_sorts($a, $b, 'arn') }
  sort { short_sorts($a, $b, 'rna') }
  sort { short_sorts($a, $b, 'ran') }

I<The results may not be as you expect if the numbers are not all the same length.>

=item numeric descending reverse

The codes C<ndr>, C<nrd>, C<dnr>, C<drn>, C<rnd>, or C<rad> can be used.

  sort { short_sorts($a, $b, 'ndr') }
  sort { short_sorts($a, $b, 'nrd') }
  sort { short_sorts($a, $b, 'dnr') }
  sort { short_sorts($a, $b, 'drn') }
  sort { short_sorts($a, $b, 'rnd') }
  sort { short_sorts($a, $b, 'rad') }

I<The results may not be as you expect if the numbers are not all the same length.>

=back

=head2 Errors

If you do not enter a code for the C<short_sort>, the following message will be returned.

  A sort type was not selected.

If you enter an invalide code for the C<short_sort>, the following message will be returned.

  <your code> is not supported.

=head1 DEPENDENCY

Fancy::Sort::Short depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;