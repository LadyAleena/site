package Random::Insanity;
use v5.10.0;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_mental_condition);

sub random_mental_condition {
  my @disorder = (
    ( map { "${_}active" } qw(hypo hyper)),
    ( map { "$_ psychosis" } qw(hallucinatory delusional)),
    'addiction', 'amnesia', 'anxiety', 'catatonia', 'dementia', 'fugue', 'manic', 'melancholy',
    'obsessive-compulsive', 'panic', 'paranoia', 'schizophrenia','split personality'
  );
  return $disorder[rand @disorder];
}

=pod

=encoding utf8

=head1 Random::Insanity

B<Random::Insanity> selects a random mental disorder.

=head2 Version

This document describes Random::Insanity version 1.000.

=head2 Synopsis

  use Random::Insanity qw(random_mental_condition);
  my $insanity = random_mental_condition;

=head2 Dependency

Random::Insanity depends on L<Exporter>.

=head2 Note

Please know this module is for fun but not making light of real disorders that affect so many people. I am very of the toll mental disorders take on people and their families.

=head2 Author

Lady Aleena

=cut

1;