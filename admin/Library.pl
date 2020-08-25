#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);

use lib '../files/lib';
use Page::Base qw(page);
use Page::File qw(file_directory);
use Page::HTML qw(section nav list anchor);
use Page::List::Alpha qw(alpha_hash alpha_menu);
use Fancy::Open qw(fancy_open);
use Number::Format::Pretty qw(commify);

my $directory = file_directory('admin');
my @files = map { "$directory/${_}_modules.txt" } ('local', 'xecu');

my $modules;
for my $file (@files) {
  my @lines = fancy_open($file);

  for my $line (@lines) {
    my ($module, $version) = split(/\t/, $line);
    $modules->{$module}++;
  }
}

my $amount = commify(scalar(keys %$modules));
my $alpha_modules = alpha_hash($modules);

for my $alpha ( keys %$alpha_modules ) {
  my @list = sort keys %{$alpha_modules->{$alpha}};
  my @modules;
  for my $module (@list) {
    my $style = $alpha_modules->{$alpha}{$module} == 1 ? 'background-color: #eed' : undef;
    my $anchor = anchor($module, { href => "https://metacpan.org/pod/$module", title => "$module on meta::cpan", target => 'cpan' });
    push @modules, [$anchor, { 'style' => $style}];
  }
  $alpha_modules->{$alpha} = \@modules;
}
my $alpha_menu = alpha_menu($alpha_modules, { join => ' | ' });

page( 'code' => sub {
  section(3, "There are $amount of modules on this list.");
  for my $alpha ( sort keys %$alpha_modules ) {
    section( 2, sub {
      list(3, 'u', $alpha_modules->{$alpha}, { 'class' => 'two links' });
      nav(3, $alpha_menu, { 'class' => 'alpha_menu' });
    }, { 'heading' => [2, $alpha, { 'id' => "section_$alpha" }] });
  };
});