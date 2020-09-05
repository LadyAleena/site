#!/usr/bin/perl
use strict;
use warnings FATAL => qw(all);

use CGI::Carp qw(fatalsToBrowser);
use FindBin qw($Bin);

use lib "../files/lib";
use Page::Base qw(page);
use Page::HTML qw(pre);
use Page::Story qw(story);

my $user = `whoami`;
chomp($user);
my $groups = `groups $user`;
chomp($groups);

my $magic = {
  'os'    => $^O,
  'perlv' => $^V,
  'user'  => $user,
  'group' => $groups,
  'uid'   => $<,
  'euid'  => $>,
  'gid'   => $(,
  'egid'  => $),
  'env'   => sub { pre(4, sub { print "$_ => $ENV{$_}\n" for sort keys %ENV }) },
  'inc_d' => sub { pre(4, sub { print "$_\n" for @INC }) },
  'inc_f' => sub { pre(4, sub { print "$_ => $INC{$_}\n" for sort keys %INC }) },
};

page(
  'code' => sub {
    story('glob' => *DATA, 'magic' => { 'doc magic' => $magic, 'line magic' => $magic })
  }
);

__DATA__
This sytem is run on ^os^ operating system and has ^perlv^ version of Perl.
2 IDs
|+ User name | ^user^
|+ Groups | ^group^
|+ Real user ID | ^uid^
|+ Effective user ID | ^euid^
|+ Real group ID | ^gid^
|+ Effective group ID | ^egid^
2 %ENV
& env
2 @INC
& inc_d
2 %INC
& inc_f