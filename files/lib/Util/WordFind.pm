package Util::WordFind;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(word_find);

use CGI::Carp qw(fatalsToBrowser);
use File::Basename;

use Util::Convert qw(filify);
use Util::Data qw(data_file);

my $lone_gender = qw(He She)[rand 2];
my $lone_adj = qw(him her)[rand 2];
my $lone_sent = ("$lone_gender may need saving! &#128558","Try to find $lone_adj please! Have fun!")[rand 2];

sub word_find {
  my ($word_find, $lone) = @_;
  my $word_find_file = filify($word_find).'.txt';
  my $boards_dir = 'Role_playing/Word_finds/boards';
  my $lists_dir  = 'Role_playing/Word_finds/lists';

  open(my $word_find_board, '<:encoding(utf-8)', data_file($boards_dir, $word_find_file)) || die "Can't open $boards_dir/$word_find_file. $!";
  open(my $word_find_list,  '<:encoding(utf-8)', data_file($lists_dir,  $word_find_file)) || die "Can't open $lists_dir/$word_find_file. $!";
  my @monsters = map { chomp; [uc $_] } <$word_find_list>;

  my $find_out = { 'list' => \@monsters, 'lonely' => $lone_sent };
  $find_out->{'board'} = do { local $/; readline($word_find_board) };

  close($word_find_board);
  close($word_find_list);

  return $find_out;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;