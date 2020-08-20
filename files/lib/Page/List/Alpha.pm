package Page::List::Alpha;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(first_alpha alpha_hash alpha_array alpha_menu);

use Encode qw(encode);

use Page::HTML qw(anchor);
use Util::Convert qw(searchify);

# The 'article' parameter.
# Without the article parameter:
## the initial articles 'a', 'an', and 'the' will be stripped from the string
## first characters will be converted to uppercase
## place all strings starting with a digit under the '#' key
## place all strings starting with a non-word characters under the '!' key
# With the article parameter, the following will be preserved:
## the initial articles 'a', 'an', and 'the'
## the case of the first characters
## all the other first characters such as digits and initial punctuation

sub first_alpha {
  my ($string, $opt) = @_;

  my $alpha;
  if ($opt->{'article'} && $opt->{'article'} =~ /^[yt1]/i) {
    $alpha = substr($string, 0, 1);
  }
  else {
    $string =~ s/\s*\b(A|a|An|an|The|the)(_|\s)//xi;

    $alpha = uc encode('UTF-8', substr($string, 0, 1));
    if ($alpha =~ /^\d/) {
      $alpha = '#';
    }
    elsif ($alpha !~ /^\p{uppercase}/) {
      $alpha = '!';
    }
  }

  return $alpha;
}

# alpha_hash and alpha_array return a hash with single character keys.

# The original list for alpha_hash is a hash.
sub alpha_hash {
  my ($org_list, $opt) = @_;
  my %alpha_hash;
  for my $org_value (keys %{$org_list}) {
    my $alpha = first_alpha($org_value, $opt);
    $alpha_hash{$alpha}{$org_value} = $org_list->{$org_value};
  }
  return \%alpha_hash;
}

# The original list for alpha_array is an array.
sub alpha_array {
  my ($org_list, $opt) = @_;
  my %alpha_hash;
  for my $org_value (@{$org_list}) {
    my $alpha = first_alpha($org_value, $opt);
    push @{$alpha_hash{$alpha}}, $org_value;
  }
  return \%alpha_hash;
}

# alpha_menu returns a string of links based on keys of a hash.
# There are two parameters and the second has several options.
## The first parameter is the hash reference with the alpha keys.
## The second parameter is the options.
### The 'param' option is for the parameter name, if there is one.
### The 'addition' option is for any items you want to add to the list.
#### The addition can be either a string or an array reference.
### The 'join' option is the character you want to use to join the list together.
### This option will cause a string to be returned.
#### The default is a comma (,).
#### Without a join, an array reference of links will be returned.

sub alpha_menu {
  my ($hash, $opt) = @_;

  my @line;
  for my $letter (sort { $a cmp $b } keys %{$hash}) {
    my $parameter    = $opt->{'param'} ? $opt->{'param'} : undef;
    my $section_name = $letter eq uc($letter) ? $letter : "l$letter";
    my $href         = $parameter ? "?$parameter=".searchify($section_name) : "#section_$section_name";
    push @line, anchor("&nbsp;$letter&nbsp;", { 'href' => $href });
  }

  if ($opt->{'addition'}) {
    push @line, ref($opt->{'addition'}) eq 'ARRAY' ? @{$opt->{'addition'}} : $opt->{'addition'};
  }

  my $join = $opt->{'join'} ? $opt->{'join'} : ', ';
  my $line = $opt->{'join'} ? join($join, @line) : \@line;

  return $line;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;