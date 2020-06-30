package Date::Verify;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(four_digit_year month_name month_number day_number);

use Data::Validate qw(is_integer is_between);
use Date::Calc qw(:all);

sub four_digit_year {
 my $year = shift;
  
  if ($year !~ /\d{4}/) {
    die "Sorry, please use the four digit year. Stopped $!";
  }

  return $year;
}

sub month_name {
  my ($month) = @_;
  
  if (is_integer($month)) {
    if (is_between($month, 1, 12)) {
      $month = Month_to_Text($month); 
    }
    else {
      die "Sorry, the month number you entered is invalid. Stopped $!";
    }
  }
  else {
    my $decoded_month = Decode_Month($month);

    if ( $decoded_month ) {
      $month = Month_to_Text($decoded_month);
    }
    else {
      die "Sorry, your month name is a little short. Stopped $!";
    }
  }
  
  return $month;
}

sub month_number {
  my ($month) = @_;
  
  if (is_integer($month)) {
    if (is_between($month, 1, 12)) {
      $month = $month;
    }
    else {
      die "Sorry, the month number you entered is invalid. Stopped $!";
    }
  }
  else {
    my $decoded_month = Decode_Month($month);

    if ( $decoded_month ) {
      $month = $decoded_month;
    }
    else {
      die "Sorry, your month name is a little short. Stopped $!";
    }
  }
  
  return $month;
}

sub day_number {
  my ($year, $month, $day) = @_;

  my $days = Days_in_Month($year, month_number($month));
  
  if ($day > $days) {
    die "Sorry, there are only $days days in $month $year. Stopped $!";
  }
  
  return $day;
}

1;