package Page::Story::Magic::IRC;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Page::HTML qw(anchor list);
use Page::Columns qw(number_of_columns);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(irc_link irc_list irc_magic);

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

sub irc_magic {
  my $dir = file_directory('Util');
  my $magic = make_hash(file => "$dir/irc.txt", headings => ['+']);

  for my $irc_list (keys %$magic) {
    my @list = @{$magic->{$irc_list}};
    $magic->{$irc_list} = undef;
    my ($server, $topic) = split(' ', $irc_list, 2);
    my $tab = $topic && $topic eq 'general' ? 4 : 5;
    $magic->{$irc_list} = sub {
      list($tab, 'u', irc_list($server, \@list));
    };
    $magic->{$server} = anchor($server, { href => "irc://$server" });
  }

  return $magic;
}


# Version 1.0
# Depends on Page::Data, Page::File, Page::HTML, Page::Columns, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;