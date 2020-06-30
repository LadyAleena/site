package Xanth::Crossbreed;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);
our @EXPORT_OK = qw(get_crossbreed);

use Fancy::Join::Defined qw(join_defined);

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

1;