package Page::Data;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(
  get_data
  data_file
  make_hash make_array
  hash_from_arrays
);

use File::Basename;
use File::Spec;

use Page::Path qw(base_path);
use Util::Sort qw(article_sort name_sort);

sub data_file {
  my ($directory, $filename, $opt) = @_;

  my $base = $opt->{'base'} ? $opt->{'base'} : 'data';
  my $ext  = $opt->{'ext'}  ? $opt->{'ext'}  : 'txt';

  my $file_name = basename($0);

  my $root_path = base_path('path');
  my $root_data = base_path($base);

  my $relative_path = File::Spec->abs2rel($file_name, $root_path);
     $relative_path =~ s/\.\w+$//;
     $relative_path =~ s/working(?:\/|\\)//;

  my $data = undef;
  if ($directory && $filename) {
    $data = "$root_data/$directory/$filename";
  }
  elsif ($directory && !$filename) {
    $data = "$root_data/$directory.$ext";
  }
  elsif (!$directory && $filename) {
    $data = "$root_data/$relative_path/$filename";
  }
  else {
    $data = "$root_data/$relative_path.$ext";
  }

  return $data;
}

# I was inspired to write get_data after I wrote fancy_rand.

sub get_data {
  my ($list, $in, $caller) = @_;

  my $out = undef;
  if ($in =~ /^(help|options)$/) {
    $out = "Your options are:
      'data' to get the hash or array
      'keys' to get the list of hash keys
      'key name' to get the key's data";
  }
  elsif (ref($list) eq 'HASH' && $in eq 'keys') {
    $out = [keys %$list];
  }
  elsif (ref($list) eq 'HASH' && $list->{$in}) {
    $out = $list->{$in};
  }
  elsif (ref($list) eq 'ARRAY' && $list->[$in]) {
    $out = $list->[$in];
  }
  elsif (!$in || $in eq 'data') {
    $out = $list;
  }

  return $out;
}

# Written with rindolf in #perlcafe on freenode; golfed with the help of [GrandFather] of PerlMonks.
# Changed to accept named parameters to make it prettier to use.
# The parameters are file and headings for make_hash and make_array.
sub make_hash {
  my %opt = @_;
  my $file = $opt{'file'} && ref($opt{'file'}) eq 'ARRAY' ? data_file(@{$opt{'file'}}) : $opt{'file'};
  open(my $fh, '<:encoding(utf-8)', $file) || die "Can not open $file$!";

  my @headings = $opt{'headings'} ? @{$opt{'headings'}} : ('heading');

  my %hash;
  while (my $line = <$fh>) {
    chomp $line;

    my @values = split(/\|/,$line);
    my $key = scalar @headings > 1 ? $values[0] : shift @values;

    my $n = 0;
    for my $r_heading (@headings) {
      if (defined($values[$n]) && length($values[$n]) > 0) {
        my $split = $r_heading =~ /\+$/ ? 1 : 0;
        (my $heading = $r_heading) =~ s/\+$//;

        my $value = $split == 1 ? [map { s/^ //r } split(/; ?/,$values[$n])] : $values[$n];

        if (scalar @headings > 1) {
          $hash{$key}{$heading} = $value;
        }
        else {
          $hash{$key} = $value;
        }
      }
      $n++;
    }
  }

  close($fh);

  return \%hash;
}

sub make_array {
  my %opt = @_;
  my $file = $opt{'file'} && ref($opt{'file'}) eq 'ARRAY' ? data_file(@{$opt{'file'}}) : $opt{'file'};
  open(my $fh, '<:encoding(utf-8)', $file) || die "Can not open $file $!";

  my @array;
  while (my $line = <$fh>) {
    chomp $line;

    my %hash;
    my @values = split(/\|/,$line);
    @hash{@{$opt{'headings'}}} = @values;

    push @array, \%hash;
  }

  close($fh);

  return \@array;
}

# I wrote hash_from_arrays when I saw the way to make two arrays into a hash.

sub hash_from_arrays {
  my ($keys, $values) = @_;

  my %hash;
  @hash{@$keys} = @$values;
  return \%hash;
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