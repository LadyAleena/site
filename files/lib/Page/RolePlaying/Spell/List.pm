package Page::RolePlaying::Spell::List;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(spell_data);

use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Util::Convert qw(filify);

sub spell_description_from_file {
  my $spell_file = shift;
  open(my $spell_fh, '<:encoding(utf-8)', $spell_file) || die "Can't open $spell_file. $!";
  my $spell_description = do { local $/; readline($spell_fh) };
  close($spell_fh);
  return $spell_description;
}

sub spell_data {
  my ($spell) = @_;

  my $spell_dir = file_directory('Role_playing');
  my @headings = (qw(name school level range duration), 'area of effect', 'components', 'casting time', 'saving throw', 'description');
  my $spells = make_hash( 'file' => "$spell_dir/spell_list.txt", 'headings' => \@headings );

  my @items;
  for my $stat (grep($_ !~ /(?:name|description)/, @headings)) {
    next if !$spells->{$spell}{$stat};
    my $stat_text = ucfirst $stat;
    push @items, qq(<strong>$stat_text:</strong> $spells->{$spell}{$stat});
  }

  my $spell_file = filify($spell);
  my @spell_description = $spells->{$spell}{'description'} ?
                          split(/\//, $spells->{$spell}{'description'}) :
                          spell_description_from_file("$spell_dir/spell_descriptions/$spell_file.txt");

  my $spell_out = { 'heading' => $spells->{$spell}{'name'}, 'stats' => [\@items, { class => 'spell_stats' }], 'description' => \@spell_description };
  return $spell_out;
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