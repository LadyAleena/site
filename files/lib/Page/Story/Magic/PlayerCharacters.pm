package Page::Story::Magic::PlayerCharacters;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(pc_magic);

use File::Spec;

use Page::Story   qw(passage);
use Fancy::Open   qw(fancy_open);
use Page::Path    qw(base_path);
use Page::RolePlaying::Spell::List qw(spell_data);
use HTML::Elements qw(list heading);
use Util::Convert qw(idify);
use Util::Data    qw(data_file);

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

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;
