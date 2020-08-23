package Fancy::Rand;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::Util qw(shuffle);
use List::MoreUtils qw(uniq);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(fancy_rand fancy_rand_from_array tiny_rand instant_rand);

sub fancy_rand {
  my ($list, $user_input, $opt) = @_;

  my $random_item;
  if ($user_input && $user_input =~ /(?:help|options)/) {
    my $keys = join("\n  ", sort keys %{$list});
    $random_item = "Your options are:
  $keys
  by keys: get a random key
  all: get a random item from any key on the list
  keys: get the list of the keys
  data: get the whole hash";
  }
  elsif ($user_input && $user_input eq 'data') {
    $random_item = $list;
  }
  elsif ($user_input && $user_input eq 'keys') {
    $random_item = [keys %$list];
  }
  else {
    my @random_list;
    if ($user_input && $user_input eq 'by keys') {
      @random_list = keys %{$list};
    }
    elsif (!$user_input || $user_input eq 'all' ) {
      @random_list = uniq(map { @$_ } values %{$list});
    }
    elsif ($list->{$user_input}) {
      @random_list = @{$list->{$user_input}};
    }
    else {
      my $caller = $opt->{caller} ? " in ".$opt->{caller} : 'fancy_rand';
      die "Your option '$user_input' is not a list $caller.\n\tStopped"
    }
    push @random_list, @{$opt->{'additions'}} if $opt->{'additions'};
    @random_list = shuffle(@random_list);
    $random_item = $random_list[rand @random_list];
  }

  return $random_item;
}

sub fancy_rand_from_array {
  my @rand_array = shuffle(@_);
  return $rand_array[rand @rand_array];
}
sub tiny_rand    { fancy_rand_from_array(@_); }
sub instant_rand { fancy_rand_from_array(@_); }

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

=cut

1;
