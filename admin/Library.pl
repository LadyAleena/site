#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);

use lib '../files/lib';
use Base::Page qw(page);
use HTML::Elements qw(section nav list anchor);
use Util::Data qw(data_file alpha_hash);
use Util::Menu qw(alpha_menu);
use Util::Number qw(commify);

my @files = map { data_file('admin', "${_}_modules.txt") } ('local', 'xecu');

my $modules;
for my $file (@files) {
  open(my $in_file, '<', $file) || die $!;
  chomp($in_file);
  my @lines = <$in_file>;

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