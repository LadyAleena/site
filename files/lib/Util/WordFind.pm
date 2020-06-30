package Util::WordFind;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(word_find);

use CGI::Carp qw(fatalsToBrowser);
use File::Basename;
use IO::All;

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

  open(my $word_find_board, '<', data_file($boards_dir, $word_find_file)) || die "Can't open $boards_dir/$word_find_file. $!";
  open(my $word_find_list,  '<', data_file($lists_dir,  $word_find_file)) || die "Can't open $lists_dir/$word_find_file. $!";
  my @monsters = map { chomp $_; [uc $_] } <$word_find_list>;

  my $find_out = { 'list' => \@monsters, 'lonely' => $lone_sent };
  $find_out->{'board'} = io(data_file('Role_playing/Word_finds/boards',$word_find_file))->slurp;

  return $find_out;
}

1;