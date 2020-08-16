package Page::IRC;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use HTML::Elements qw(anchor);
use Util::Columns  qw(number_of_columns);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(irc_link irc_list);

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

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;