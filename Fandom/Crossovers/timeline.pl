#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use File::Basename;
use HTML::Entities qw(encode_entities);
use Date::Calc qw(Month_to_Text);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::HTML qw(section list paragraph);
use Page::Story qw(story);
use Page::List::File     qw(file_directory file_list file_menu);
use Page::Story::Inline  qw(inline);
use Fancy::Join::Defined qw(join_defined);
use Fancy::Open qw(fancy_open);
use Util::Convert qw(textify);
use Util::Sort    qw(article_sort);

sub convert_month {
  my $month = shift;
  return $month ? Month_to_Text( $month ) : undef;
}

my $directory = file_directory('Fandom/Crossovers/Timelines');
my @selects = map { textify($_) } sort { article_sort(lc $a,lc $b) } file_list($directory);

my $cgi = CGI::Simple->new;
my $select = encode_entities($cgi->param('timeline'),'<>"');
my $head = $select && grep(/\Q$select\E/, @selects) ? "$select timeline" : 'Crossover timelines';
my $file_menu = file_menu('timeline', \@selects);


my %years;
if ($select && grep(/\Q$select\E/, @selects)) {
  $select =~ s/ /_/g;
  my $file = "$directory/$select.txt";
  my @lines = fancy_open($file);

  my %activities;
  for my $line (@lines) {
    if ($line =~ /^\d{4}/) {
      my ($year, $month, $day, $activity) = split(' ', $line, 4);
      push @{$activities{$year}{$month}{$day}}, inline($activity);
    }
  }

  for my $year ( sort { $a <=> $b } keys %activities ) {
    my $a_month    = keys %{$activities{$year}}                        == 1 ? (keys %{$activities{$year}})[0]           : undef;
    my $a_day      = $a_month && keys %{$activities{$year}{$a_month}}  == 1 ? (keys %{$activities{$year}{$a_month}})[0] : undef;
    my $a_activity = $a_day && @{$activities{$year}{$a_month}{$a_day}} == 1 ? $activities{$year}{$a_month}{$a_day}[0]   : undef;
    my $a_line     = join_defined(': ', join_defined(' ', (convert_month($a_month), $a_day)), $a_activity);

    my $year_list;
    if ($a_month && $a_day && !$a_activity) {
      push @$year_list, [$a_line, { inlist => ['u', $activities{$year}{$a_month}{$a_day}] }];
    }
    elsif ($a_month && !$a_day) {
      my $month_list;
      for my $day ( sort { $a <=> $b } keys %{$activities{$year}{$a_month}} ) {
        $a_activity = @{$activities{$year}{$a_month}{$day}} == 1 ? $activities{$year}{$a_month}{$day}[0] : undef;

        if ($a_activity) {
          push @$month_list, "$day: $a_activity";
        }
        else {
          push @$month_list, [$day, { inlist => ['u', $activities{$year}{$a_month}{$day}] }];
        }
      }
      push @$year_list, [convert_month($a_month), { inlist => ['u', $month_list] }];
    }
    elsif (!$a_month) {
      for my $month ( sort { $a <=> $b } keys %{$activities{$year}} ) {
        $a_day      = keys %{$activities{$year}{$month}}              == 1 ? (keys %{$activities{$year}{$month}})[0] : undef;
        $a_activity = $a_day && @{$activities{$year}{$month}{$a_day}} == 1 ? $activities{$year}{$month}{$a_day}[0]   : undef;
        $a_line     = join_defined(': ', join_defined(' ', (convert_month($month), $a_day)), $a_activity);

        if ($a_day && !$a_activity) {
          push @$year_list, [$a_line, { inlist => ['u', $activities{$year}{$month}{$a_day}] }];
        }
        elsif (!$a_day) {
          my $month_list;
          for my $day ( sort { $a <=> $b } keys %{$activities{$year}{$month}} ) {
            $a_activity = @{$activities{$year}{$month}{$day}} == 1 ? $activities{$year}{$month}{$day}[0] : undef;

            if ($a_activity) {
              push @$month_list, "$day: $a_activity";
            }
            else {
              push @$month_list, [$day, { inlist => ['u', $activities{$year}{$month}{$day}] }];
            }
          }
          push @$year_list, [$a_line, { inlist => ['u', $month_list] }];
        }
        else {
          push @$year_list, $a_line;
        }
      }
    }
    else {
      push @$year_list, $a_line;
    }
    $years{$year} = $year_list;
  }
}

page( 'heading' => $head, 'file menu' => $file_menu, 'code' => sub {
  if (%years) {
    for my $year ( sort { $a <=> $b } keys %years ) {
      section(3, sub {
        list(5, 'u', $years{$year});
      }, { 'heading' => [2, $year] });
    }
  }
  else {
    section(3, sub {
      paragraph(5, "Here are the timelines for some of the crossover continuities.");
      list(5, 'u', $file_menu, { 'class' => 'three' });
    });
  }
});
