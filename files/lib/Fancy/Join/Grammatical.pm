package Fancy::Join::Grammatical;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(grammatical_join);

# Written with the help of DrForr in #perlcafe on freenode.
sub grammatical_join {
  my $conj = shift(@_) . ' ';
  return $_[0] if @_ <= 1;
  return join( ' '.$conj, @_ ) if @_ == 2;
  my $punc = grep( /,/, @_ ) ? '; ' : ', ';
  push @_, $conj.pop;
  join($punc, @_);
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
