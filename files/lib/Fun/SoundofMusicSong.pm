package Fun::SoundofMusicSong;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(
  SoM_song SoM_def random_SoM_note random_SoM_song
  some_song some_def random_some_note random_some_song
);

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

sub some_song        { return SoM_song(@_) }
sub some_def         { return SoM_def(@_) }
sub random_some_note { return random_SoM_note(@_) }
sub random_some_song { return random_SoM_song(@_) }

=pod

=encoding utf8

=head1 NAME

B<Fun::SoundofMusicSong> returns songs based on the note names from the film I<The Sound of Music>.

=head1 VERSION

This document describes Fun::SoundofMusicSong version 1.0.

=head1 SYNOPSIS

  use Fun::SoundofMusicSong qw(
    SoM_song
    some_song
    SoM_def
    some_def
    random_SoM_note
    random_some_note
    random_SoM_song
    random_some_song
  );

  my $song        = SoM_song('c d e f g a b');
  my $song_def    = SoM_def('c d e f g a b');
  my $random_note = random_SoM_note();
  my $random_song = random_SoM_song(20);

=head1 DESCRIPTION

Fun::SoundofMusicSong is a whimsical module written for fun and hopefully to entertain. It is based on the song "Do-Re-Ml" in I<The Sound of Music>. You can generate songs from the notes as named in the film, get the definitions of those notes, and generate random notes and songs.

All of the subroutines in this module can also be used if you replace C<SoM> with C<some>. This was done for those who have troulbe typing and are using alternate methods to do so, such as speech. "some" is a real word, so it will be easier to use for some alternate methods.

=head2 SoM_song

I<C<some_song> is an alias for C<SoM_song>>.

C<SoM_song> returns an array rerference of notes as named in I<The Sound of Music> as they are entered using their alphabetical names in a string and separated by spaces, commas, or semi-colons. If a letter that is not a musical note is entered, the value of that note will be C<not a note>.

  my $space_song = SoM_song('a b c d e f g');
  my $comma_song = SoM_song('a, b, c, d, e, f, g');
  my $semic_song = SoM_song('a; b; c; d; e; f; g');

  my $space_song_easy = some_song('a b c d e f g');
  my $comma_song_easy = some_song('a, b, c, d, e, f, g');
  my $semic_song_easy = some_song('a; b; c; d; e; f; g');

They will all return an array ref:

  [
    'la',
    'te',
    'do',
    're',
    'me',
    'fa',
    'so'
  ];

=head2 SoM_def

I<C<some_def> is an alias for C<SoM_def>>.

C<SoM_def> returns an array rerference of notes as named in I<The Sound of Music> with their definitions as they are entered using their alphabetical names in a string and separated by spaces, commas, or semi-colons. If a letter that is not a musical note is entered, the value of that note will be C<not a note>.

  my $space_song_def = SoM_song('a b c d e f g');
  my $comma_song_def = SoM_song('a, b, c, d, e, f, g');
  my $semic_song_def = SoM_song('a; b; c; d; e; f; g');

  my $space_song_easy_def = some_song('a b c d e f g');
  my $comma_song_easy_def = some_song('a, b, c, d, e, f, g');
  my $semic_song_easy_def = some_song('a; b; c; d; e; f; g');

They will all return an arrray ref:

  [
    'la a note to follow so',
    'te a drink with jam and bread',
    'do a deer a female deer',
    're a drop of golden sun',
    'me a name I call myself',
    'fa a long long way to run',
    'so a needle pulling thread'
  ];

=head2 random_SoM_note

I<C<random_some_note> is an alias for C<random_SoM_note>>.

C<random_SoM_note> will rezurn one random note as named in I<The Sound of Music>.

  my $random_note      = random_SoM_note();
  my $random_note_easy = random_some_note();

=head2 random_SoM_song

I<C<random_some_song> is an alias for C<random_SoM_song>>.

C<random_SoM_song> will return a random selection of notes as named in I<The Sound of Music>, up to the amount entered. If no number is entered the song will be between 1 and 100 notes long.

  my $random_song      = random_SoM_song(20);
  my $random_song_easy = random_some_song(20);

Sample random song:

  [
    'te',
    're',
    'la',
    'do',
    'la',
    're',
    'te',
    'fa',
    'la',
    'so',
    'do',
    'do',
    'te',
    're',
    'do',
    'la',
    'do',
    'fa',
    'me',
    'fa'
  ];

=head1 DEPENDENCY

Fun::SoundofMusicSong depends on L<Exporter>.

=head1 AUTHOR

Lady Aleena with lots of help from PerlMonks.

=cut

1;