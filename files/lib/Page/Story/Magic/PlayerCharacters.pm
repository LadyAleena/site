package Page::Story::Magic::PlayerCharacters;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use File::Spec;

use Page::File qw(file_path);
use Page::HTML qw(list heading);
use Page::Path qw(base_path);
use Page::Story qw(passage);
use Page::Convert qw(idify);
use Page::RolePlaying::Spell::List qw(spell_data);
use Fancy::Open   qw(fancy_open);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(pc_magic);

sub pc_magic {
  my @pcs = fancy_open(file_path('Role_playing','player_characters_list.txt'));

  my $magic;
  for my $pc (@pcs) {
    my $root = base_path('path');
    my $id   = idify($pc);
    my $path = File::Spec->abs2rel("$root/Role_playing/Player_characters/index.pl#$id");
    $magic->{$pc} = qq(A<$pc|href="$path">);

    my ($first, $last) = split(' ', $pc, 2);
    $magic->{$first} = qq(A<$first|href="$path">);
  }

  $magic->{'spells'} = sub {
    for my $spell_in ('Find Beacon','Teleport Beacon','Secure Teleport') {
      my $spell = spell_data($spell_in);
      heading(4, 3, $spell->{'heading'});
      list(5, 'u', @{$spell->{'stats'}});
      passage(5, $spell->{'description'});
    }
  };

  return $magic;
}

# Version 1.0
# Depends on Page::Convert, Page::Data, Page::File, Page::HTML, Page::Path, Page::Story, Page::RolePlaying::Spell::List, Fancy::Open, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;