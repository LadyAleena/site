package Page::Story::Magic::PlayerCharacters;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use File::Spec;

use Page::Data qw(data_file);
use Page::HTML qw(list heading);
use Page::Path qw(base_path);
use Page::Story qw(passage);
use Page::RolePlaying::Spell::List qw(spell_data);
use Fancy::Open   qw(fancy_open);
use Util::Convert qw(idify);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(pc_magic);

sub pc_magic {
  my @pcs = fancy_open(data_file('Role_playing','player_characters_list.txt'));

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

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::PlayerCharacters> exports the doc and line magic for my various pages where I need links to my Player character page.

=head1 VERSION

This document describes Page::Story::Magic::PlayerCharacters version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::PlayerCharacters depends on Page::Data, Page::HTML, Page::Path, Page::Story, Page::RolePlaying::Spell::List, Fancy::Open, Util::Convert, and L<Exporter>

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
