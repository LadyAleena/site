#!/usr/bin/perl
# This is the site index.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib 'files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use Page::Story::Magic qw(story_magic);
use Page::IRC      qw(irc_list);
use HTML::Elements qw(section heading list anchor);

my $cgi       = CGI::Simple->new;
my $page      = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir = 'files/text';
my $page_file = "$pages_dir/index.txt";
my $heading   = 'index';
if ($page && $page eq 'about') {
  $page_file  = "$pages_dir/about.txt";
  $heading    = 'About Lady Aleena';
}
elsif ($page && $page eq 'irc') {
  $page_file  = undef;
  $heading    = 'IRC channels I visit';
}

my %irc = (
  freenode => {
    web        => [qw(css html httpd svg javascript web)],
    linux      => [qw(linux debian linuxmint winehq alsa bash rsync sed awk)],
    databases  => [qw(sql yaml)],
    mediawiki  => [qw(autowikibrowser mediawiki mediawiki-scripts wikimedia wikimedia-commons wikimedia-tech wikipedia wikipedia-en wikipedia-en-help wikipedia-plot wikipedia-social wp-doctor-who)],
    programs   => [qw(git firefox videolan notepad++ geany gramps graphviz hexchat inkscape xchat vim emacs libreoffice)],
    social     => [qw(perlcafe chat css-ot debian-offtopic linux-offtopic kde-chat web-social git-offtopic)],
    general    => [qw(freenode comcast-users scifi hardware programming design)],
    'desktop environments' => [qw(kde gnome xfce)],
    kde        => [qw(kde amarok kde-women kontact okular)],
  },
  slashnet => {
    general => ['perlmonks'],
  },
  oftc => {
    general => [qw(debian debian-apache debian-offtopic debian-kde)],
  },
);

my $magic = story_magic;
page(
  'heading' => $heading,
  'code' => sub {
    if (!$page || $page eq 'about') {
      open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";
      story($page_fh, { 'line magic' => $magic })
    }
    elsif ($page && $page eq 'irc') {
      section(3, 'These are the <b>IRC channels</b> where I chat sometimes, though not all at once. I am <code>Lady_Aleena</code> on IRC or other aliases with <code>Aleena</code> such as <code>Scary_Aleena</code> for Halloween.');
      for my $server (sort { lc $a cmp lc $b } keys %irc) {
        section(3, sub {
          list(4, 'u', irc_list($server, $irc{$server}{'general'}));
          for my $subject (sort { lc $a cmp lc $b } grep { !/general/ } keys %{$irc{$server}}) {
            heading(4, 3, $subject);
            list(5, 'u', irc_list($server, $irc{$server}{$subject}, $subject));
          }
        }, { 'heading' => [2, anchor($server, { 'href' => "irc://$server" })] });
      }
    }
  }
);
