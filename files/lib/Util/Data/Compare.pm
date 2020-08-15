package Util::Data::Compare;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(data_compare);

use Data::Compare;
use Data::Dumper;

use Util::Line qw(line);

sub data_compare {
  my ($tab, $data, $old_data, $new_data) = @_;

  my $old = $old_data;
  my $new = $new_data;
  my $main_c = Data::Compare->new($old, $new);
  if ($main_c->Cmp == 0) {
    line($tab, $data);

    if (ref($old) eq 'HASH' && ref($new) eq 'HASH') {
      line($tab + 1, 'old to new');
      for (keys %$old) {
        data_compare($tab + 2, $_, $$old{$_}, $$new{$_});
      }
    }
    elsif (ref($old) eq 'ARRAY' && ref($new) eq 'ARRAY') {
      for my $ix ( 0 .. $#{ $old } ) {
        data_compare($tab + 2, map { $_->[ $ix ] } ($old, $new));
      }
    }
    else {
      print Dumper($new);
      print Dumper($old);
    }
  }
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