package Page::Xanth::Crossbreed;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Join::Defined qw(join_defined);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(get_crossbreed);

sub get_crossbreed {
  my ($characters, $character) = @_;

  my $species = $character->{species}->[-1];

  my $full_species;
  if ($species eq 'crossbreed') {
    my @species_list;
    for my $parent_type ( qw(mother father) ) {
      my $parent_name = $character->{family}->{$parent_type}->[0] ? $character->{family}->{$parent_type}->[0] : undef;

      my $parent_species = undef;
      if ($parent_name) {
        if ( $parent_name =~ /^[a-z]/ && $parent_name ne 'unknown' ) {
          $parent_species = $parent_name;
        }
        else {
          my $parent = $characters->{$parent_name};
          $parent_species = get_crossbreed($characters, $parent);
        }
      }
      $parent_species = 'human' if ($parent_species && $parent_species eq 'curse fiend');
      push @species_list, $parent_species;
    }
    $full_species = join_defined('/', @species_list);
  }

  return $full_species? $full_species : $species;
}

=pod

=encoding utf8

=head1 VERSION

This document describes Xanth::Crossbreed version 1.0.

=head1 DEPENDENCIES

Page::Xanth::Crossbreed depends on L<Fancy::Join::Defined> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;