package Zodiac::Chinese;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(chinese_zodiac);

my @direction = qw(yang yin);
my @element = (("metal") x 2, ("water") x 2, ("wood") x 2, ("fire") x 2, ("earth") x 2);
my @signs = qw(rat ox tiger rabbit dragon snake horse sheep monkey rooster dog pig);

sub chinese_zodiac {
  my ($year,$month,$day) = @_;
  my $zodiac;
  if ($month > 1) {
    $zodiac = $direction[$year % 2]." ".$element[$year % 10]." ".$signs[($year - 1924) % 12];
  }
  else {
    $zodiac = $direction[($year - 1) % 2]." ".$element[($year - 1) % 10]." ".$signs[(($year-1)  - 1924) % 12];
  }
  return $zodiac;
}

=head1 NAME

B<Zodiac::Chinese> generates one's Chinese zodiac. However, for those born in late January to early February, it may be wrong.

=head2 Use

To use this module, please enter the following.

  use qw(chinese_zodiac);

To generate one's Chinese zodiac sign, please use the example below.

  chinese_zodiac(YEAR,MONTH)  YEAR is the 4-digit year, MONTH is the digit for the month (1-12)

=head1 AUTHOR

Lady Aleena with help of ik and mofino in the #perlcafe on freenode.

=cut

1;