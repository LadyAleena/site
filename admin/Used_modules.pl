#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use File::Find;

use lib '../files/lib';
use Base::Page qw(page story);
use HTML::Elements qw(table list);
use Util::Data qw(file_list);
use Util::Path qw(base_path);

my $root_path = base_path('path');

my $files;
sub wanted {
  my $file = $_ =~/.p[lm]$/ ? $File::Find::name : undef;
  push @$files, $file if $file;
}
find(\&wanted, $root_path);

sub find_modules {
  my ($files, $in_uses) = @_;
  my $uses = $in_uses;
  for (@$files) {
    open(my $fh, '<', $_) || die $!;
    my $loop = 0;
    while (my $line = <$fh>) {
      chomp $line;
      last if ($line eq '=head1 NAME');
      $uses->{$1}++ if $line =~ /^use ((\w|\:)+)(.+)$/;
      warn "$_ isn't using strict, $!"   if ($loop == 1 && $line !~ /use strict/ && $_ !~ /index/);
      warn "$_ isn't using strict, $!"   if ($loop == 2 && $line !~ /use strict/ && $_ =~ /index/);
      warn "$_ isn't using warnings, $!" if ($loop == 2 && $line !~ /use warnings/ && $_ !~ /index/);
      warn "$_ isn't using warnings, $!" if ($loop == 3 && $line !~ /use warnings/ && $_ =~ /index/);
      $loop++;
    }
  }
  return $uses;
}

my $modules = find_modules($files);
my @rows = map([$_, $modules->{$_}], sort { $modules->{$b} <=> $modules->{$a} || $a cmp $b } keys %$modules);
# my @rows = map([$_, $modules->{$_}], sort { $a cmp $b } keys %$modules);
my $magic;
$magic->{'table'} = sub {
  table(3, {
    id => 'used_modules_data',
    class => 'number',
    rows => [['header', [['Module', 'Used']]], ['data', \@rows]]
  })
};
$magic->{'list'} = sub {
  list(3, 'u', [sort @$files], { style => 'font-size: small' });
};

page( 'code' => sub { story(*DATA, { 'doc magic' => $magic }) });

__DATA__
& table
& list
