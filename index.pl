#!/usr/bin/perl
# This is the site index.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);

use lib 'files/lib';
use Base::Page     qw(page story);
use HTML::Elements qw(section heading list anchor);
use Util::Columns  qw(number_of_columns);
use Util::Convert  qw(searchify);
use Util::Data     qw(file_directory file_list);
use Util::Menu     qw(file_menu);
use Util::Sort     qw(article_sort);
use Util::StoryMagic qw(story_magic);

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
    web        => [qw(css html httpd svg javascript web design)],
    linux      => [qw(linux debian linuxmint winehq alsa bash rsync sed awk)],
    perl       => [qw(perlcafe cbstream)],
    computing  => [qw(firefox hardware programming videolan sql yaml notepad++ geany gramps graphviz hexchat inkscape xchat vim emacs libreoffice)],
    mediawiki  => [qw(autowikibrowser mediawiki mediawiki-scripts wikimedia wikimedia-commons wikimedia-tech wikipedia wikipedia-en wikipedia-en-help wikipedia-plot wikipedia-social wp-doctor-who)],
    social     => [qw(chat css-ot debian-offtopic linux-offtopic kde-chat web-social)],
    general    => [qw(freenode comcast-users scifi)],
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

sub irc_link {
  my ($server, $channel) = @_;
  my @double_bang = qw(chat windows linux gnome javascript linuxmint design hardware programming linux-offtopic css-ot);
  my $channel_link = grep($_ eq $channel, @double_bang) ? '##'.$channel : $channel;
  return anchor($channel, { href => "irc://$server/$channel_link" });
}

sub irc_list {
  my ($server, $list, $subject) = @_;
  my @channel_list = map { irc_link( $server, $_ ) } sort { lc $a cmp lc $b } @$list;
  return (\@channel_list, { 'class' => number_of_columns(4, scalar @channel_list, 1) });
}

my $magic = story_magic;
page(
  'heading' => $heading,
  'code' => sub {
    if (!$page || $page eq 'about') {
      open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";
      story($page_fh, { 'line magic' => $magic })
    }
    elsif ($page && $page eq 'irc') {
      section(3, 'These are the <b>IRC channels</b> where I chat sometimes, though not all at once.');
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
