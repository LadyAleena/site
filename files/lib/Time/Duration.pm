package Time::Duration;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(duration);

sub duration {
  my ($var) = @_;
  my $total_seconds;
  for my $duration (@{$var}) {
    my $split = ($duration =~ tr/\://);
    my ($hours,$minutes,$seconds);
    if ($split == 1) {
      $hours = 0;
      ($minutes,$seconds) = split(':',$duration);
    }
    elsif ($split == 2) {
      ($hours,$minutes,$seconds) = split(':',$duration);
    }
    else {
      die "Split didn't work";
    }
    $total_seconds += (($hours * 60) * 60) + ($minutes * 60) + $seconds;
  }

  my $total_minutes = int($total_seconds/60);
  my $total_hours   = int($total_minutes/60);
  my $total_days    = int($total_hours/24);
  my $total_weeks   = int($total_days/7);

  my $mod_seconds = $total_seconds % 60;
  my $mod_minutes = $total_minutes % 60;
  my $mod_hours   = $total_hours % 24;
  my $mod_days    = $total_days % 7;

  my @times = ($mod_days, $mod_hours, $mod_minutes, $mod_seconds);
  shift @times while @times && $times[0] == 0;

  return join(":", @times)."\n";
}

=pod

=encoding utf8

=head1 NAME

B<Time::Duration> returns time duration.

=head1 DEPENDENCIES

Time::Duration depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;