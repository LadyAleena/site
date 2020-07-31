package Time::Duration;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(duration);

sub duration {
  my ($time_list) = @_;
  my $total_seconds;
  for my $duration (@{$time_list}) {
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

B<Time::Duration> returns total time from a list of smaller durations.

=head1 VERSION

This document describes Time::Duration version 1.0.

=head1 SYNOPSIS

  use Time::Duration qw(duration);

  my @times = qw(3:58 2:48 4:28 5:06 6:50 5:33 4:05 3:29 4:48 6:19);

  my $total_time = duration(\@times);
    # returns 47:24

=head1 DEPENDENCIES

Time::Duration depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;