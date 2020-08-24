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

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;

# unused titles: grand duke/duchess; landgrave/landgravine; marquess, marquis/marchioness; burgrave/burgravine; earl; baronet; knight; knight bachelor
