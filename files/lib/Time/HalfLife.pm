package Time::HalfLife;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(half_life_date);

use Date::Calc qw(:all);

sub half_life_date {
  my ($meeting, $birthdate) = @_;
  my $date_difference = Delta_Days(@$birthdate, @$meeting);
  my ($double_year, $double_month, $double_day) = Add_Delta_Days(@$meeting,$date_difference);
  my $birthday = $birthdate->[2]." ".Month_to_Text($birthdate->[1])." ".$birthdate->[0];
  my $double_date = $double_day." ".Month_to_Text($double_month)." ".$double_year;

  my %half_life;
  $half_life{birthday} = $birthday;
  $half_life{days_from_birth} = $date_difference;
  $half_life{half_life_date} = $double_date;

  return \%half_life;
}

=pod

=encoding utf8

=head1 NAME

B<Time::HalfLife> returns when half a person's life has happened.

=head1 DEPENDENCIES

Time::Duration depends on L<Date::Calc> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;