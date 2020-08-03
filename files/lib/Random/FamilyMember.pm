package Random::FamilyMember;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::MoreUtils qw(uniq);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(
  random_family_member
  random_parent
  random_generational_parent
  random_extended_parent
  random_ancestor
  random_child
  random_generational_child
  random_extended_child
  random_descendent
  random_sibling
  random_extended_sibling
  random_nibling
  random_generational_nibling
  random_pibling
  random_generational_pibling
  random_cousin
  random_spouse
  random_extended_spouse
  random_friend
  random_extended_friend
);

my @generations = ('', 'grand', 'great-grand', 'ancestral ');

sub get_generations {
  my $person = shift;
  my $last = pop @generations if $person !~ /mother|father/;
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
$family_members{'descendents'} = [
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

sub random_parent               { my $user_addition = shift; random_family_member('parents'              , $user_addition) }
sub random_generational_parent  { my $user_addition = shift; random_family_member('generational parents' , $user_addition) }
sub random_extended_parent      { my $user_addition = shift; random_family_member('extended parents'     , $user_addition) }
sub random_ancestor             { my $user_addition = shift; random_family_member('ancestors'            , $user_addition) }

sub random_child                { my $user_addition = shift; random_family_member('children'             , $user_addition) }
sub random_generational_child   { my $user_addition = shift; random_family_member('generational children', $user_addition) }
sub random_extended_child       { my $user_addition = shift; random_family_member('exteneded children'   , $user_addition) }
sub random_descendent           { my $user_addition = shift; random_family_member('descendents'          , $user_addition) }

sub random_sibling              { my $user_addition = shift; random_family_member('siblings'             , $user_addition) }
sub random_extended_sibling     { my $user_addition = shift; random_family_member('extended siblings'    , $user_addition) }

sub random_nibling              { my $user_addition = shift; random_family_member('niblings'             , $user_addition) }
sub random_generational_nibling { my $user_addition = shift; random_family_member('generational niblings', $user_addition) }

sub random_pibling              { my $user_addition = shift; random_family_member('piblings'             , $user_addition) }
sub random_generational_pibling { my $user_addition = shift; random_family_member('generational piblings', $user_addition) }

sub random_cousin               { my $user_addition = shift; random_family_member('cousins'              , $user_addition) }

sub random_spouse               { my $user_addition = shift; random_family_member('spouses'              , $user_addition) }
sub random_extended_spouse      { my $user_addition = shift; random_family_member('extended spouses'     , $user_addition) }

sub random_friend               { my $user_addition = shift; random_family_member('friends'              , $user_addition) }
sub random_extended_friend      { my $user_addition = shift; random_family_member('extended friends'     , $user_addition) }

=pod

=encoding utf8

=head1 NAME

B<Random::FamilyMember> selects random family members.

=head1 VERSION

This document describes Random::FamilyMember version 1.000.

=head1 SYNOPSIS

  use Random::FamilyMember qw(random_family_member);

  my $family_member = random_family_member;

  my $parent               = random_parent;
  my $generational_parent  = random_generational_parent;
  my $extended_parent      = random_extended_parent;
  my $ancestor             = random_ancestor;

  my $child                = random_child;
  my $generational_child   = random_generational_child;
  my $extended_child       = random_extended_child;
  my $descendent           = random_descendent;

  my $sibling              = random_sibling;
  my $extended_sibling     = random_extended_sibling;

  my $nibling              = random_nibling;
  my $generational_nibling = random_generational_nibling;

  my $pibling              = random_pibling;
  my $generational_pibling = random_generational_pibling;

  my $sousin               = random_cousin;

  my $spouse               = random_spouse;
  my $extended_spouse      = random_extended_spouse;

  my $friend               = random_friend;
  my $extended_friend      = random_extended_friend;

  print random_family_member('help') # get random_family_member options

=head1 DESCRIPTION

Random::FamilyMember selects random family members from many generations and of various relationships.

It requires Perl version 5.10.0 or better.

=head2 random_family_member

=head3 Options

=head4 nothing, all, or undef

  random_family_member();
  random_family_member('all');
  random_family_member(undef);

These options will select any value in any list. You can read the options below to see all of the potential values.

=head4 Parent options

=over

=item parents

  random_family_member('parents');

The C<parents> option will select from mother and father.

=item generational parents

  random_family_member('generational parents');

The C<generational parents> option will select from mother, father, grandmother, grandfather, great-grandmother, great-grandfather, ancestal mother, and ancestral father.

=item extended parents

  random_family_member('extended parents');

The C<exented parents> option will select from mother, father, step-mother, step-father, mother-in-law, and father-in-law.

=item ancestors

  random_family_member('ancestors');

The C<ancestors> option will select from all of the other parent options.

=back

=head4 Child options

=over

=item children

  random_family_member('children');

The C<children> option will select from daughter and son.

=item generational children

  random_family_member('generational children');

The C<generational children> option will select from daughter, son, granddaughter, grandson, great-granddaughter, and great-grandson.

=item extended children

  random_family_member('extended children');

The C<extended children> option will select from daughter, son, step-daughter, step-son, daughter-in-law, and son-in-law.

=item descendents

  random_family_member('descendents');

The C<descendents> option will select from all of the other children options.

=back

=head4 Sibling options

=over

=item siblings

  random_family_member('siblings');

The C<siblings> option will select from sister and brother.

=item extended siblings

  random_family_member('extended siblings');

The C<extended siblings> option will select from sister, brother, step-sister, step-brother, sister-in-law, and brother-in-law.

=back

=head4 Nibling options

=over

=item niblings

  random_family_member('niblings');

The C<niblings> option will select from niece and nephew.

=item generational niblings

  random_family_member('generational niblings');

The C<generational niblings> option will select from niece, nephew, grandniece, grandnephew, great-grandniece, and great-grandnephew.

=back

=head4 Pibling options

=over

=item piblings

  random_family_member('piblings');

The C<piblings> option will select from aunt and uncle.

=item generational piblings

  random_family_member('generational piblings');

The C<generational piblings> option will select from aunt, uncle, grandaunt, granduncle, great-grandaunt, and great-granduncle.

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

The C<spouses> option will select from wife and husband.

=item extended spouses

  random_family_member('extended spouses');

The C<extended spouses> option will select from wife, husband, ex-wife, and ex-husband.

=back

=head4 Friend options

=over

=item friends

  random_family_member('friends');

The C<friends> option will select from girlfriend and boyfriend.

=item extended friends

  random_family_member('extended friends');

The C<extended friends> option will select from girlfriend, boyfriend, ex-girlfriend, and ex-boyfriend.

=back

=head4 by keys

  random_family_member('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_family_member('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_family_member('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_family_member('help');
  random_family_member('options');

The C<help> and C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('family 1', 'family 2');
  random_family_member('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head2 Specific functions

The following functions are shortcuts to the some of the options above. You can add items to the list by adding an array reference with the additional items as the first parameter in the following functions. If you want to add additional parents in C<random_base_parent>, you would do the following:

  my @parent_additions = ('mom', 'dad');
  random_base_parent(\@parent_additions);

=head3 Parents

=head4 random_parent

  random_parent();

C<random_parent> is the same as using L</parents> in C<random_family_member>.

=head4 random_generational_parent

  random_generational_parent();

C<random_generational parent> is the same as using L</generational parents> in C<random_family_member>.

=head4 random_extended_parent

  random_extended_parent();

C<random_extended_parent> is the same as using L</extended parents> in C<random_family_member>.

=head4 random_ancestor

  random_ancestor();

C<random_ancestor> is the same as using L</ancestors> in C<random_family_member>.

=head3 Children

=head4 random_child

  random_child();

C<random_child> is the same as using L</children> in C<random_family_member>.

=head4 random_generational_child

  random_generational_child();

C<random_generational_child> is the same as using L</generational children> in C<random_family_member>.

=head4 random_extended_child

  random_extended_child();

C<random_extended_child> is the same as using L</extended children> in C<random_family_member>.

=head4 random_descendent

  random_descendent();

C<random_descendent> is the same as using L</descedents> in C<random_family_member>.

=head3 Siblings

=head4 random_sibling

  random_sibling();

C<random_sibling> is the same as using L</siblings> in C<random_family_member>.

=head4 random_extended_sibling

  random_extended_sibling();

C<random_extended_sibling> is the same as using L</exended siblings> in C<random_family_member>.

=head3 Niblings

=head4 random_nibling

  random_nibling();

C<random_nibling> is the same as using L</niblings> in C<random_family_member>.

=head4 random_generational_nibling

  random_generational_nibling();

C<random_generational_nibling> is the same as using L</generational niblings> in C<random_family_member>.

=head3 Piblings

=head4 random_pibling

  random_pibling();

C<random_pibling> is the same as using L</piblings> in C<random_family_member>.

=head4 random_generational_pibling

  random_generational_pibling();

C<random_generational_pibling> is the same as using L</piblings> in C<random_family_member>.

=head3 Cousins

=head4 random_cousin

  random_cousin();

C<random_cousin> is the same as using L</cousins> in C<random_family_member>.

=head3 Spouses

=head4 random_spouse

  random_spouse();

C<random_spouse> is the same as using L</spouses> in C<random_family_member>.

=head4 random_extended_spouse

  random_extended_spouse();

C<random_extended_spouse> is the same as using L</extended spouses> in C<random_family_member>.

=head3 Friends

=head4 random_friend

  random_friend();

C<random_friend> is the same as using L</friends> in C<random_family_member>.

=head4 random_extended_friend

  random_extended_friend();

C<random_extended_friend> is the same as using L</extended friends> in C<random_family_member>.

=head1 DEPENDENCIES

Random::FamilyMember depends on L<Fancy::Rand>, L<List::MoreUtils>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;
