package Random::FamilyMember;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::MoreUtils qw(uniq);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_family_member);

my @generations = ('', 'grand', 'great-grand', 'ancestral ');

sub get_generations {
  my $person = shift;
  my $last = $person !~ /mother|father/ ? pop @generations : undef;
  my @generational_people = map("${_}$person", @generations);
  push @generations, $last if $last;
  return @generational_people;
}

my %family_members = (
  'parents'  => [qw(mother father)],
  'children' => [qw(daughter son)],
  'siblings' => [qw(sister brother)],
  'niblings' => [qw(niece nephew)],
  'piblings' => [qw(aunt uncle)],
  'cousins'  => ['cousin'],
  'spouses'  => [qw(wife husband)],
  'friends'  => [qw(girlfriend boyfriend)],
);
$family_members{'generational parents'}  = [ map(get_generations($_), @{$family_members{'parents'}}) ];
$family_members{'generational children'} = [ map(get_generations($_), @{$family_members{'children'}}) ];
$family_members{'generational niblings'} = [ map(get_generations($_), @{$family_members{'niblings'}}) ];
$family_members{'generational piblings'} = [ map(get_generations($_), @{$family_members{'piblings'}}) ];
$family_members{'extended parents'} = [
  @{$family_members{'parents'}},
  map("step-$_", qw(mother father)),
  map("${_}-in-law", qw(mother father)),
];
$family_members{'extended children'} = [
  @{$family_members{'children'}},
  map("step-$_", qw(daughter son)),
  map("${_}-in-law", qw(daughter son)),
];
$family_members{'extended siblings'} = [
  @{$family_members{'siblings'}},
  map("step-$_", qw(sister brother)),
  map("${_}-in-law", qw(sister brother)),
];
$family_members{'extended spouses'} = [
  @{$family_members{'spouses'}},
  map("ex-$_", qw(wife husband)),
];
$family_members{'extended friends'} = [
  @{$family_members{'friends'}},
  map("ex-$_", qw(girlfriend boyfriend)),
];
$family_members{'ancestors'} = [
  uniq(
    @{$family_members{'generational parents'}},
    @{$family_members{'extended parents'}},
  )
];
$family_members{'descendants'} = [
  uniq(
    @{$family_members{'generational children'}},
    @{$family_members{'extended children'}},
  )
];

sub random_family_member {
  my ($user_member, $user_additions) = @_;
  my $family_type = fancy_rand(\%family_members, $user_member, { caller => 'random_family_member', additions => $user_additions ? $user_additions : undef });
  return $family_type;
}

=pod

=encoding utf8

=head1 NAME

B<Random::FamilyMember> returns a random family member.

=head1 VERSION

This document describes Random::FamilyMember version 1.000.

=head1 SYNOPSIS

  use Random::FamilyMember qw(random_family_member);

  my $family_member = random_family_member;

  my $parent               = random_family_member('parents');
  my $generational_parent  = random_family_member('generational parents');
  my $extended_parent      = random_family_member('extended parents');
  my $ancestor             = random_family_member('ancestors');

  my $child                = random_family_member('children');
  my $generational_child   = random_family_member('generational children');
  my $extended_child       = random_family_member('extended children');
  my $descendant           = random_family_member('descendants');

  my $sibling              = random_family_member('siblings');
  my $extended_sibling     = random_family_member('extended siblings');

  my $nibling              = random_family_member('niblings');
  my $generational_nibling = random_family_member('generational niblings');

  my $pibling              = random_family_member('piblings');
  my $generational_pibling = random_family_member('generational piblings');

  my $cousin               = random_family_member('cousins');

  my $spouse               = random_family_member('spouses');
  my $extended_spouse      = random_family_member('extended spouses');

  my $friend               = random_family_member('friends');
  my $extended_friend      = random_family_member('extended friends');

  print random_family_member('help') # get random_family_member options

=head1 DESCRIPTION

Random::FamilyMember returns a random family member from many generations and of various relationships.

It requires Perl version 5.10.0 or better.

=head2 random_family_member

=head3 Options

=head4 nothing, all, or undef

  random_family_member;
  random_family_member();
  random_family_member('all');
  random_family_member(undef);

These options will select any value in any list. You can read the options below to see all of the potential values.

=head4 Parent options

=over

=item parents

  random_family_member('parents');

The C<parents> option returns mother or father.

=item generational parents

  random_family_member('generational parents');

The C<generational parents> option returns mother, father, grandmother, grandfather, great-grandmother, great-grandfather, ancestal mother, or ancestral father.

=item extended parents

  random_family_member('extended parents');

The C<exented parents> option returns mother, father, step-mother, step-father, mother-in-law, or father-in-law.

=item ancestors

  random_family_member('ancestors');

The C<ancestors> option returns one from all of the other parent options.

=back

=head4 Child options

=over

=item children

  random_family_member('children');

The C<children> option returns daughter or son.

=item generational children

  random_family_member('generational children');

The C<generational children> option returns daughter, son, granddaughter, grandson, great-granddaughter, or great-grandson.

=item extended children

  random_family_member('extended children');

The C<extended children> option returns daughter, son, step-daughter, step-son, daughter-in-law, or son-in-law.

=item descendents

  random_family_member('descendants');

The C<descendents> option returns one from all of the other children options.

=back

=head4 Sibling options

=over

=item siblings

  random_family_member('siblings');

The C<siblings> option returns sister or brother.

=item extended siblings

  random_family_member('extended siblings');

The C<extended siblings> option returns sister, brother, step-sister, step-brother, sister-in-law, or brother-in-law.

=back

=head4 Nibling options

=over

=item niblings

  random_family_member('niblings');

The C<niblings> option returns niece or nephew.

=item generational niblings

  random_family_member('generational niblings');

The C<generational niblings> option returns niece, nephew, grandniece, grandnephew, great-grandniece, or great-grandnephew.

=back

=head4 Pibling options

=over

=item piblings

  random_family_member('piblings');

The C<piblings> option returns aunt or uncle.

=item generational piblings

  random_family_member('generational piblings');

The C<generational piblings> option returns aunt, uncle, grandaunt, granduncle, great-grandaunt, or great-granduncle.

=back

=head4 Cousin option

=over

=item cousins

  random_family_member('cousins');

The C<cousins> option will return cousin.

=back

=head4 Spouse options

=over

=item spouses

  random_family_member('spouses');

The C<spouses> option returns wife or husband.

=item extended spouses

  random_family_member('extended spouses');

The C<extended spouses> option returns wife, husband, ex-wife, or ex-husband.

=back

=head4 Friend options

=over

=item friends

  random_family_member('friends');

The C<friends> option returns girlfriend or boyfriend.

=item extended friends

  random_family_member('extended friends');

The C<extended friends> option returns girlfriend, boyfriend, ex-girlfriend, or ex-boyfriend.

=back

=head4 by keys

  random_family_member('by keys');

The C<by keys> option returns a random key listed above.

=head4 keys

  random_family_member('keys');

The C<keys> option returns all of the available keys in an array reference.

=head4 data

  random_family_member('data');

The C<data> option returns the data used in a hash reference.

=head4 help or options

  random_family_member('help');
  random_family_member('options');

The C<help> or C<options> options returns a list of all of your options.

=head3 Adding items to a list

  my @additions = ('family 1', 'family 2');
  random_family_member('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head1 DEPENDENCIES

Random::FamilyMember depends on L<Fancy::Rand>, L<List::MoreUtils>, and L<Exporter>.

=head1 NOTE

While looking for collective nouns for niece and nephew and aunt and uncle, I came across the terms nibling and pibling in L<this article|https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1570791/>.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;
