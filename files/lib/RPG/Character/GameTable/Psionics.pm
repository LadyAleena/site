package RPG::Character::GameTable::Psionics;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(psionics_by_level psionics_table_rows);

use Util::Data qw(make_hash);
use RPG::Character::Class qw(class_level);

# part of the Character Building table suite.

sub psionics_by_level {
  my ($class, $opt) = @_;
  my $level = $opt->{'level'} ? $opt->{'level'} : class_level($class, $opt->{'experience'});

  my $psionics = make_hash(
    'file' => ['Role_playing/Classes/Psionics', 'progression.txt'],
    'headings' => ['level', 'disciplines', 'sciences', 'devotions', 'defense modes'],
  );

  return $psionics->{$level} ? $psionics->{$level} : undef;
}

sub psionics_table_rows {
  my %opt = @_;
  my $xp  = $opt{'experience'};

  my $psionics = psionics_by_level('psionisist', { 'experience' => $xp });
  my @data_rows;
  push @data_rows, [ucfirst $_, $psionics->{$_}] for ('disciplines', 'sciences', 'devotions', 'defense modes');

  my @rows = (
    ['header', [['&nbsp;','Amount']]],
    ['whead', \@data_rows]
  );

  return \@rows;
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