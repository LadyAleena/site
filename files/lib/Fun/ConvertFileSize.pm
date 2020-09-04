package Fun::ConvertFileSize;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::SomeUtils qw(firstidx apply);
use Number::Format::BigFloat qw(format_number);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(convert_filesize);

local $\ = "\n";

my @filesize_names = qw(byte kilobyte megabyte gigabyte terabyte petabyte exabyte zettabyte yottabyte);

# I put the these sizes here just for my information.
# my %little_filesizes;
# $little_filesizes{bit}    = 1;
# $little_filesizes{nibble} = $little_filesizes{bit} * 4;
# $little_filesizes{byte}   = $little_filesizes{bit} * 8;

sub make_singular {
  my $word = shift;
     $word =~ s/s$//;
  my @short_sizes = apply { s/^(\w)\w{1,}$/$1b/ } @filesize_names;
  if (grep(/^\L$word\E$/, @short_sizes)) {
    $word = $filesize_names[firstidx { $_ eq lc $word } @short_sizes];
  }
  return $word;
}

# from tye: my %hash; @hash{@sizes} = 0..$#sizes;
# from MidLifeXis: $result = $original * $units{$inmultiplier} / $units{$outmultiplier}

sub convert_filesize {
  my %opt = @_;

  my $from = firstidx { $_ eq make_singular($opt{from}) } @filesize_names;
  my $to   = firstidx { $_ eq make_singular($opt{to}) } @filesize_names;
  my $dec  = $opt{decimals} ? $opt{decimals} : 0;
  my $base = $opt{base} ? $opt{base} : 1024;

  my ($diff, $converted);

  if ( $from > $to ) {
    $diff = $from - $to;
    $converted = $opt{size} * ($base ** $diff);
  }
  elsif ( $to > $from ) {
    $diff = $to - $from;
    $converted = $opt{size} / ($base ** $diff);
  }
  else {
    $converted = $opt{size};
  }

  my $org_filesize = format_number($opt{size}, { decimal_digits => $dec });
  my $new_filesize = format_number($converted, { decimal_digits => $dec });
  return "$org_filesize $opt{from} is $new_filesize $opt{to}";
}

=pod

=encoding utf8

=head1 NAME

B<Fun::ConvertFileSize> converts one file size to another file size like gigabytes to kilobytes and the reverse.

=head1 VERSION

This document describes Fun::ConvertFileSize version 1.0.

=head1 SYNOPSIS

To use this script, please use the following.

  use Fun::ConvertFileSize qw(convert_filesize random_filesize);

  my $conversion = convert_filesize(
    size => 10101101,
    from => 'megabytes',
    to => 'kb',
    decimals => 2,
    base => 1000,
  );
  #10,101,101 megabytes is 10,101,101,000 kb


=head1 DESCRIPTION

Fun::ConvertFileSize converts one file size to another file size like gigabytes to kilobytes and the reverse. The C<convert_filesize> function must be imported into your script.

C<random_filesize_unit> returns a random file size unit and is included for fun.

=head2 convert_filesize

C<convert_filesize> must be imported into your script and has the following parameters.

=head3 Parameters

=head4 size

C<size> is the original size you want to convert and is required.

=head4 from

C<from> is the filesize unit name you want to convert from and is required.

=head4 to

C<to> is the filesize unit name you want to convert to and is required.

=head4 decimals

C<decimals> is the how many decimals you want returned. Conversions from smaller to larger can lead to a lot of decimals places. The default is 0.

=head4 base

C<base> is how many of a smaller is in a larger. Some systems use 1024 as the base while others use 1000. The default is 1024.

=head3 from and to

For the from and to fields, you do not have to worry about case.

  byte(s) or bb
  kilobyte(s) or kb
  megabyte(s) or mb
  gigabyte(s) or gb
  terabyte(s) or tb
  petabyte(s) or pb
  exabyte(s) or eb
  zettabyte(s) or zb
  yottabyte(s) or yb

=head1 DEPENDENCIES

Fun::ConvertFileSize depends on L<Number::Format::BigFloat>, L<List::SomeUtils>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena with lots of help from PerlMonks.

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;