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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
