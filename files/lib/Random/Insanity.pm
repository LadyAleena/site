package Random::Insanity;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
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

=head1 NAME

B<Random::Insanity> selects a random mental disorder.

=head1 SYNOPSIS

  use Random::Insanity qw(random_mental_condition);
  my $insanity = random_mental_condition;

=head1 DEPENDENCY

Random::Insanity depends on L<Exporter>.

=head1 NOTE

Please know this module is for fun but not making light of real disorders that affect so many people. I am very of the toll mental disorders take on people and their families.

=head1 AUTHOR

Lady Aleena

=cut

1;