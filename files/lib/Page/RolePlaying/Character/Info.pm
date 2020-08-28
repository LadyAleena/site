package Page::RolePlaying::Character::Info;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(pc_info_list pc_info_table);

use Lingua::EN::Inflect qw(PL_N);

use Page::HTML qw(span);
use Page::Number::Pretty qw(pretty_number);
use RPG::Alignment qw(expand_alignment);
use Page::RolePlaying::Character::Class qw(player_classes_with_level);
use Util::Convert qw(idify textify);

# This is used in the simple player character index.

sub pc_info_list {
  my ($data_hash, $hash_headings) = @_;
  my @items;
  for my $key (@$hash_headings) {
    my $value = span($data_hash->{$key});
    push @items, qq(<strong class="caps">).ucfirst $key.qq(:</strong> $value);
  }
  return \@items;
}

# This is used in the game table player character index.

sub pc_info_table {
  my ($character, $table) = @_;
  my $name = textify($character->{'name'}."'s");
  my $table_id = idify("$name $table");

  my %tables = (
    'general'    => [qw(class experience hit_points)],
    'appearance' => [qw(gender height weight hair eyes)],
    'background' => [qw(alignment race), 'special race', qw(homeland tribe clan family religion status)],
  );

  my $caption = $table ne 'general' ? "$name $table" : undef;

  my @rows;
  for my $info (@{$tables{$table}}) {
    if ($character->{$info} ) {
      my $class_array = player_classes_with_level($character->{'class'}, $character->{'experience'});
      my $head = $info ne 'class' ? textify($info) : PL_N($info, scalar(@$class_array));
      my $data = $character->{$info} =~ /^\d+$/ ? pretty_number($character->{$info}) :
                 $info eq 'class' ? join( '<br>', @$class_array):
                 $info eq 'alignment' ? expand_alignment($character->{$info}) : $character->{$info};
      push @rows, [ucfirst $head, $data];
    }
  }

  return { 'id' => "$table_id", 'class' => 'player_character pc_info_table', 'caption' => $caption, 'rows' => [['whead',\@rows]] };
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
