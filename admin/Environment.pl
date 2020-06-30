#!/usr/bin/perl
use strict;
use warnings FATAL => qw(all);

use CGI::Carp qw(fatalsToBrowser);

use lib "../files/lib";
use Base::Page qw(page story);
use HTML::Elements qw(pre);

my $user = `whoami`;
chomp($user);
my $groups = `groups $user`;
chomp($groups);

my $magic = {
  'user'  => $user,
  'group' => $groups,
  'uid'   => $<,
  'euid'  => $>,
  'gid'   => $(,
  'egid'  => $),
  'env'   => sub { pre(4, sub { print "$_ => $ENV{$_}\n" for sort keys %ENV }) },
  'inc_d' => sub { pre(4, sub { print "$_\n" for @INC }) },
  'inc_f' => sub { pre(4, sub { print "$_ => $INC{$_}\n" for sort keys %INC }) },
  'os'    => $^O,
  'perlv' => $^V,
};

page( 'code' => sub { story(*DATA, { 'doc magic' => $magic, 'line magic' => $magic }) });

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