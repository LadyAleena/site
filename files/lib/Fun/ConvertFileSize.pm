package Fun::ConvertFileSize;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::MoreUtils qw(firstidx apply);

use lib '../../fantasy/files/lib';
use Util::Number qw(pretty_number);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(convert_filesize random_filesize);

local $\ = "\n";

my @filesize_names = qw(bit nibble byte kilobyte megabyte gigabyte terabyte petabyte exabyte zettabyte yottabyte);

# I put the these sizes here just for my information.
my %little_filesizes;
$little_filesizes{bit}    = 1;
$little_filesizes{nibble} = $little_filesizes{bit} * 4;
$little_filesizes{byte}   = $little_filesizes{bit} * 8;

# I never know when I'll want a random file size.
sub random_filesize_unit {
  return $filesize_names[rand @filesize_names]
}

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

  # I took out bits and nibbles just to keep me sane.
  my @filesizes = grep(/byte/, @filesize_names);

  my $from = firstidx { $_ eq make_singular($opt{from}) } @filesizes;
  my $to   = firstidx { $_ eq make_singular($opt{to}) } @filesizes;
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

  my $org_filesize = pretty_number($opt{size}, $dec);
  my $new_filesize = pretty_number($converted, $dec);
  return "$org_filesize $opt{from} is $new_filesize $opt{to}";
}

=pod

=encoding utf8

=head1 NAME

B<Fun::ConvertFileSize> converts one filesize to another filesize like gigabytes to kilobytes and the reverse.
There is also a random filesize generator included for fun.

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

=head2 convert_filesize

C<convert_filesize> has the following options.

=over

=item size

C<size> is the original size you want to convert and is required.

=item from

C<from> is the filesize name you want to convert from and is required.

=item to

C<to> is the filesize name you want to convert to and is required.

=item decimals

C<decimals> is the how many decimals you want returned. Conversions from smaller to larger can lead to a lot of decimals places. The default is 0.

=item base

C<base> is how many of a smaller is in a larger. Some use 1024 as the base while others use 1000. Default is 1024.

=back

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


=head2 random_filesize

To use the random generator if you happen to have a secret agent protecting a file of a size you don't feel like coming up with, you'd do...

  my $random_filesize = random_filesize();

You could get anything from a bit to a yottabyte.

=head1 DEPENDENCIES

Fun::ConvertFileSize depends on L<Exporter>, L<List::MoreUtils>, and L<Util::Number>.

=head1 AUTHOR

Lady Aleena with lots of help from PerlMonks.

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;