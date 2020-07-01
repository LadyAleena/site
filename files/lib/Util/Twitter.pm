package Util::Twitter;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(consumer_key consumer_key_secret access_key access_key_secret nt_with_retry twitter_accounts tweet_date seconds_since time_since tweet_wrap target_new_subscribers);

use DateTime;
use DateTime::Format::Strptime;
use Date::Calc qw(Delta_DHMS Delta_YMDHMS);
use Lingua::EN::Inflect qw(PL_N NO);
use POSIX qw(ceil);
use Time::HiRes qw(sleep);
use Try::Tiny;

use lib '..';
use Util::Data qw(data_file);

open(my $key_file,'<',data_file('Twitter','tokens.txt')) || die "You didn't get the path or file right Dawn. $!";
my @tokens_data = <$key_file>;
chomp @tokens_data;

my @tokens;
my $main_iteration = 0;
for my $key_line (@tokens_data) {
  my @line = split(/\|/,$key_line);
  my $key_iteration = 0;
  for my $key (qw(access_token access_token_secret user_id screen_name)) {
    $tokens[$main_iteration]{$key} = $line[$key_iteration];
    $key_iteration++;
  }
  $main_iteration++;
}

sub consumer_key {
  return 'MR8VkpDsu6OOklSEO5dsDw';
}

sub consumer_key_secret {
  return 'ieE3muGogD3B9axMAb3B1a46WoL2TflXDJUBbwZQPWk';
}

sub access_key {
  my $screen_name = shift;
  for (0..$#tokens) {
    return $tokens[$_]{access_token} if $tokens[$_]{screen_name} eq $screen_name;
  }
}

sub access_key_secret {
  my $screen_name = shift;
  for (0..$#tokens) {
    return $tokens[$_]{access_token_secret} if $tokens[$_]{screen_name} eq $screen_name;
  }
}

sub nt_with_retry {
  my ($nt,$method,@args) = @_;

  my $result;
  my $redo = 0;
  my $delay = 0.25;
  do {
    try {
      $result = $nt->$method(@args);
    }
    catch {
      die $_ if try { $_->code != 200 && $_->code < 500 } catch { 1 };
      print STDERR $_;
      print $_->http_response->request->as_string;
      $redo++;
      sleep $delay;
      $delay *= 2;
    }
  } while ( !$result && $redo < 11 );

  return $result;
}

sub twitter_accounts {
  my @accounts = qw(
    Lady_Aleena
    LadyAleena_ABC
    LadyAleena_CBS
    LadyAleena_FOX
    LadyAleena_NBC
    LadyAleena_SyFy
    LadyAleena_TNT
    LadyAleena_USA
    LadyAleena_TV
    LadyAleena_eros
    LadyAleena_home
    LadyAleena_test
  );

  return @accounts;
}

sub tweet_date {
  my $date = shift;

  my @units = qw(year month day hour minute second);

  my $Strp = new DateTime::Format::Strptime(
    pattern => '%a %b %d %T %z %Y',
  );

  my $dt = $Strp->parse_datetime($date);
  $dt->set_time_zone('America/New_York');

  my @new_time = map($dt->$_,@units);
  my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

  my ($D_y,$D_m,$D_d, $Dh,$Dm,$Ds) = Delta_YMDHMS(
    @new_time,
    $year + 1900,$mon + 1,$mday,$hour,$min,$sec
  );

  my $iteration = 0;
  my @delta_time = ($D_y,$D_m,$D_d,$Dh,$Dm,$Ds);
  my @time_since;
  for (@units) {
    push @time_since, $delta_time[$iteration]." ".PL_N($_,$delta_time[$iteration]);
    $iteration++;
  }

  shift @time_since while @time_since && $time_since[0] =~ /^0/;
  my $time_since_t = shift @time_since;

  my $tweet_time = $dt->format_cldr('d MMMM YYYY H:mm');
  return "$time_since_t ago on $tweet_time";
}

sub seconds_since {
  my $date = shift;
  my @units = qw(year month day hour minute second);

  my $Strp = new DateTime::Format::Strptime(
    pattern => '%a %b %d %T %z %Y',
  );

  my $dt = $Strp->parse_datetime($date);
  if ($dt) {
    $dt->set_time_zone('America/New_York');

    my @new_time = map($dt->$_,@units);
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);

    my ($Dd,$Dh,$Dm,$Ds) = Delta_DHMS(
      @new_time,
      $year + 1900,$mon + 1,$mday,$hour,$min,$sec
    );

    my $seconds = $Ds;
    $seconds += $Dm * 60;
    $seconds += ($Dh * 60) * 60;
    $seconds += (($Dd * 24) * 60) * 60;

    return $seconds;
  }
  else {
    return 0;
  }
}

sub time_since {
  my $date = shift;

  if ($date) {
    my $base_seconds = seconds_since($date);
    my $seconds = $base_seconds % 60;

    my $base_minutes = int($base_seconds / 60);
    my $minutes = $base_minutes % 60;

    my $base_hours = int($base_minutes / 60);
    my $hours = $base_hours % 24;

    my $base_days = int($base_hours / 24);
    my $days = $base_days % 7;

    my $base_weeks = int($base_days / 7);
    my $weeks = $base_weeks % 4.33;

    my $base_months = int($base_weeks / 4.33);
    my $months = $base_months % 12;

    my $years = int($base_months / 12);

    my @units = qw(year month week day hour minute second);
    my @times = ($years,$months,$weeks,$days,$hours,$minutes,$seconds);

    my @time;
    my $iteration = 0;
    for (@units) {
      push @time, $times[$iteration]." ".PL_N($_,$times[$iteration]);
      $iteration++;
    }

    return join(" ",grep { $_ !~ /^0/} @time);
  }
  else {
    return '';
  }
}

sub tweet_wrap {
  my ($tweet_tag,$tweeter_array) = @_;

  my $space = 139 - length($tweet_tag);
  my $tweeters = '';

  my @tweets;
  for my $tweeter (sort { lc $a cmp lc $b } @{$tweeter_array}) {
    if (length($tweeters) + 1 + length($tweeter) > $space) {
      push @tweets, $tweet_tag . $tweeters;
      $tweeters = '';
    }
    $tweeters .= " \@$tweeter";
  }
  push @tweets, $tweet_tag . $tweeters if length($tweeters);

  return @tweets;
}

sub target_new_subscribers {
  my ($members,$subscribers) = @_;

  my $square_root = sqrt($members);
  my $int_root = ceil($square_root);
  my $target = $int_root ** 2;
  $target++ if $target == $members;
  my $result = $target - $subscribers;
  my $return = $result < 0 ? 0 : $result;
  return $return;
}

1;