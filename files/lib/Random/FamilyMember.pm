package Random::FamilyMember;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use List::Util qw(uniq);

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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;
