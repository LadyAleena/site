package Random::Title;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Rand qw(fancy_rand);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_title);

my %titles = (
  'noble male'   => [qw(emperor king prince archduke duke count viscount baron squire master lord)],
  'noble female' => [qw(empress queen princess archduchess duchess countess viscountess baroness dame mistress lady)],
  'military'     => [qw(marshal general colonel major captain lieutenant sergeant corporal private)],
  'naval'        => [qw(admiral captain commander lieutenant ensign seaman)],
  'government'   => [qw(president secretary senator governor director commissioner mayor administrator manager)],
);

sub random_title {
  my ($user_title, $user_additions) = @_;
  my $title = fancy_rand(\%titles, $user_title, { caller => 'random_title', additions => $user_additions ? $user_additions : undef });
  return $title;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Title> returns a random title of a person.

=head1 VERSION

This document describes Random::Title version 1.000.

=head1 SYNOPSIS

  use Random::Title qw(random_title);

  my $title            = random_title();

  my $noble_male       = random_title('noble male');
  my $noble_female     = random_title('noble female');
  my $military_rank    = random_title('military');
  my $naval_rank       = random_title('naval');
  my $government_title = random_title('government');

  print random_title('help'); # get random_title options

=head1 DESCRIPTION

Random::Title returns a random title of a person.

=head2 random_title

=head3 Options

=head4 nothing, all, or undef

  random_title;
  random_title();
  random_title('all');
  random_title(undef);

These options return any value in any list. You can read the options below to see all of the potential values.

=head4 noble male

  random_title('noble male');

The C<noble male> option returns emperor, king, prince, archduke, duke, count, viscount, baron, squire, master, or lord.

=head4 noble female

  random_title('noble female');

The C<noble female> option returns empress, queen, princess, archduchess, duchess, countess, viscountess, baroness, dame, mistress, or lady.

=head4 military

  random_title('military');

The C<military> option returns marshal, general, colonel, major, captain, lieutenant, sergeant, corporal, or private.

=head4 navel

  random_title('navel');

The C<naval> option returns admiral, captain, commander, lieutenant, ensign, or seaman.

=head4 government

  random_title('government');

The C<government> options returns president, secretary, senator, governor, director, commissioner, mayor, administrator, or manager.

=head4 by keys

  random_title('by keys');

The C<by keys> option will select a random key listed above.

=head4 keys

  random_title('keys');

The C<keys> option will list all of the available keys in an array reference.

=head4 data

  random_title('data');

The C<data> option will return the data used in a hash reference.

=head4 help or options

  random_title('help');
  random_title('options');

The C<help> or C<options> options will return a list of all of your options.

=head3 Adding items to a list

  my @additions = ('title 1', 'title 2');
  random_title('<your option>', \@additions);

You can add items to the list by adding an array reference with the additional items as the second parameter.

=head1 DEPENDENCIES

Random::Title depends on L<Fancy::Rand> and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=head1 LICENCE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;

# unused titles: grand duke/duchess; landgrave/landgravine; marquess, marquis/marchioness; burgrave/burgravine; earl; baronet; knight; knight bachelor