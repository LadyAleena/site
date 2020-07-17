package Fun::SoundofMusicSong;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(SoM_song SoM_def random_SoM_note random_SoM_song);

my @base_notes = qw(c d e f g a b);
my @SoM_notes  = qw(do re me fa so la te);

my %notes;
@notes{@base_notes} = @SoM_notes;

my $SoM = {
  'do' => 'a deer a female deer',
  're' => 'a drop of golden sun',
  'me' => 'a name I call myself',
  'fa' => 'a long long way to run',
  'so' => 'a needle pulling thread',
  'la' => 'a note to follow so',
  'te' => 'a drink with jam and bread',
};

sub SoM_song {
  my ($user_song) = @_;
  my @song_notes = split(/[ ,;]/, $user_song);
  my @new_song = map { /^[a-g]$/ ? $notes{$_} : 'not a note' } @song_notes;
  return \@new_song;
}

sub SoM_def {
  my ($user_song) = @_;
  my $notes = SoM_song($user_song);
  my @new_song = map { $SoM->{$_} ? $_.' '.$SoM->{$_} : 'not a note' } @$notes;
  return \@new_song;
}

sub random_SoM_note {
  my $note = $SoM_notes[rand @SoM_notes];
  return $note;
}

sub random_SoM_song {
  my ($number_of_notes) = @_;
  my $notes = $number_of_notes ? $number_of_notes : int(rand(100)) + 1;
  my @new_song;
  push @new_song, random_SoM_note for (1..$notes);
  return \@new_song;
}

=pod

=encoding utf8

=head1 NAME

B<Fun::SoundofMusicSong> returns songs based on the note names from the film I<The Sound of Music>.

=head1 SYNOPSIS

  use Fun::SoundofMusicSong qw(
    SoM_song
    SoM_def
    random_SoM_note
    random_SoM_song
  );

  my $song        = SoM_song('c d e f g a b');
  my $song_def    = SoM_def('c d e f g a b');
  my $random_note = random_SoM_note();
  my $random_song = random_SoM_song(20);

=head1 DEPENDENCY

Fun::SoundofMusicSong depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena with lots of help from PerlMonks.

=cut

1;