package Util::QuoteAttribute;
use v5.8.8;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(quote_attributes);

sub quote_attributes {
  my ($line) = @_;
     $line =~ s/(\w+\=)((\w|\/|\.)+\b)/$1"$2"/g;
  #   $line =~ s/(\w+\=)(\w+\S*)/$1"$2"/g;
  return $line;
}

=pod

=encoding utf8

=head1 NAME

B<Util::QuoteAttribute> quotes attributes within html element tags which are not already quoted.

=head1 VERSION

This document describes Util::QuoteAttribute version 1.0.

=head1 DEPENDENCY

Util::QuoteAttribute depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;