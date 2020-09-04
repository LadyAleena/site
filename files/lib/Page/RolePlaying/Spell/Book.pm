package Page::RolePlaying::Spell::Book;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(spellbook);

use Lingua::EN::Inflect qw(ORD);

use Page::Data    qw(make_hash);
use Page::Columns qw(number_of_columns);

sub spellbook {
  my ($file) = @_;

  my $spells = make_hash( 'file' => $file, 'headings' => ['+'] );

  my $spell_list;
  for my $level (sort keys %$spells) {
    next if $level eq 'Note';
    my @spells = @{$spells->{$level}};
    my $columns = number_of_columns(3, scalar @spells, 1);
    push @$spell_list, { 'heading' => ORD($level).' level', 'list' => [\@spells, { class => $columns }] };
  }
  if ($spells->{'Note'}) {
    push @$spell_list, { 'heading' => 'Note about this spellbook', 'paragraph' => $spells->{'Note'}[0] };
  }
  return $spell_list;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;