package Page::Story::Magic::MagicItem;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(NO);

use Page::HTML qw(list anchor);
use Page::File qw(file_directory file_list);
use Util::Convert qw(searchify textify);
use Util::Sort    qw(name_sort);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(magic_item_magic);

sub magic_item_magic {
  my $magic;

  for my $count (0..9) {
    my $charges = ucfirst NO('charge', $count, { words_below => 101 });
    $magic->{$charges} = qq(STRONG<$charges:>);
  }

  $magic->{'XP'} = 'ABBR<XP|title="experience point value">';
  $magic->{'GP'} = 'ABBR<GP|title="gold piece value">';
  $magic->{'MR'} = 'ABBR<MR|title="magic resistance">';

  $magic->{'magic items of the specialist'} = 'A<magic items of the specialist|href="?select=magic+items+of+the+specialist">';

  $magic->{'spellbooks'} = sub {
    my $spellbook_dir  = file_directory('Role_playing/Player_characters/Spellbooks');
    my @spellbook_list = sort { name_sort(textify($a),textify($b)) } file_list($spellbook_dir);
    my @spellbooks;
    for my $spellbook (@spellbook_list) {
      my $text = textify($spellbook);
      my $search = searchify($text);
      push @spellbooks, anchor($text, { href => qq(../Player_characters/Spellbooks.pl?spellbook=$search) });
    }
    list(4, 'u', \@spellbooks, { 'class' => 'three' })
  };

  return $magic;
}

=pod

=encoding utf8

=head1 NAME

B<Page::Story::Magic::MagicItem> exports the doc and line magic for my Magic items pages.

=head1 VERSION

This document describes Page::Story::Magic::MagicItem version 1.0.

=head1 DEPENDENCIES

Page::Story::Magic::Miscellany depends on Page::HTML, Page::File, Util::Convert, Util::Sort, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;