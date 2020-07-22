package Fancy::Open;
use v5.10.0;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_open);

sub fancy_open {
  my ($filename, $opt) = @_;
  my $encoding = $opt->{'encoding'} // 'utf-8';
  open(my $fh, "<:encoding($encoding)", $filename) or die "Can't open $filename. $!";

  my $before = $opt->{'before'} // '';
  my $after  = $opt->{'after'}  // '';

  my @array;
  while ( my $line = <$fh> ) {
    chomp $line;
    my $final_line = $before . $line . $after;
    push @array, $final_line;
  }
  close($fh);

  return @array;
}

=pod

=encoding utf8

=head1 NAME

B<Fancy::Open> opens and creates an array for a file.

=head1 VERSION

This document describes Fancy::Open version 1.0.

=head1 SYNOPSIS

  use Fancy::Open qw(fancy_open);

  my @plain_array  = fancy_open($file_nane);
    # returns an array for the file with no additions

  my @before_array = fancy_open($file_name, { 'before' => 'foo' });
    # returns an array for the file with foo prepended to each item

  my @after_array  = fancy_open($file_name, { 'after' => 'bar; });
    # returns an array for the file with bar appended to each item

  my @both_array   = fancy_open($file_name, { 'before' => 'foo', 'after' => 'bar' });
    # returns an array for the file with foo prepended and bar appended to each item

=head1 DESCRIPTION

C<fancy_open> can be exported and returns a list of values. These values can be modified if the optional parameters C<before>, C<after>, or both are used. There is the additional option to choose your C<encoding>, the default is C<uft-8>.

  my @fancy_array = fancy_open($filename, { 'before' => $before_value, 'after' => $after_value });

If the open fails, fancy_open will die with a message with the filename and the captured error.

=head1 DEPENDENCY

Fancy::Open depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;
