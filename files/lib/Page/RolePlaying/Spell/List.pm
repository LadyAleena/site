package Page::RolePlaying::Spell::List;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(spell_data);

use Encode qw(encode);

use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Util::Convert qw(filify);
use Fancy::Open qw(fancy_open);

sub spell_data {
  my ($spell) = @_;

  my $spell_dir = file_directory('Role_playing');
  my @headings = (qw(name school level range duration), 'area of effect', 'components', 'casting time', 'saving throw');
  my $spells = make_hash( 'file' => "$spell_dir/spell_list.txt", 'headings' => \@headings );

  my @items;
  for my $stat (grep($_ !~ /(?:name)/, @headings)) {
    next if !$spells->{$spell}{$stat};
    my $stat_text = ucfirst $stat;
    push @items, encode('UTF-8', qq(<strong>$stat_text:</strong> $spells->{$spell}{$stat}));
  }

  my $spell_file = filify($spell);
  my $spell_desc = "$spell_dir/spell_descriptions/$spell_file.txt";
  my @spell_description = -e $spell_desc ? map { encode('UTF-8', $_) } fancy_open("$spell_dir/spell_descriptions/$spell_file.txt") : undef;

  my $spell_out = { 'heading' => $spells->{$spell}{'name'}, 'stats' => [\@items, { class => 'spell_stats' }], 'description' => \@spell_description };
  return $spell_out;
}

# No longer in use

sub spell_description_from_file {
  my $spell_file = shift;
  open(my $spell_fh, '<:encoding(utf-8)', $spell_file) || die "Can't open $spell_file. $!";
  my $spell_description = do { local $/; readline($spell_fh) };
  close($spell_fh);
  return $spell_description;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;