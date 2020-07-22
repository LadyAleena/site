package Date::HalfLife;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Date::Calc qw(Delta_Days Add_Delta_Days Month_to_Text);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(half_life_date);

sub half_life_date {
  my ($meeting, $birthdate) = @_;
  my $date_difference = Delta_Days(@$birthdate, @$meeting);
  my ($double_year, $double_month, $double_day) = Add_Delta_Days(@$meeting,$date_difference);
  my $birthday = $birthdate->[2]." ".Month_to_Text($birthdate->[1])." ".$birthdate->[0];
  my $double_date = $double_day." ".Month_to_Text($double_month)." ".$double_year;

  my %half_life;
  $half_life{'birthday'} = $birthday;
  $half_life{'days from birth'} = $date_difference;
  $half_life{'half life date'} = $double_date;

  return \%half_life;
}

=pod

=encoding utf8

=head1 Date::HalfLife

B<Date::HalfLife> returns when half a person's life has happened after an event.

=head2 Version

This document describes Date::HalfLife version 1.0.

=head2 Synopsis

  use Date::HalfLife qw(half_life_date);

  my $half_life = half_life_date(
    [$event_year, $event_month, $event_day],
    [$birth_year, $birth_month, $birth_day]
  );
    # returns a hashref

=head2 Dependencies

Date::HalfLife depends on L<Date::Calc> and L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;