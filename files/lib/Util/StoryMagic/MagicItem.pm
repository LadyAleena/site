package Util::StoryMagic::MagicItem;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(magic_item_magic);

use Lingua::EN::Inflect qw(NO);

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
  return $magic;
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