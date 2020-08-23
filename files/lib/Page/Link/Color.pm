package Page::Link::Color;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(link_color);

sub link_color {
  my $file  = shift;
  my $color = '000';

  my %colors;
  $colors{'pl'}    = '069';
  $colors{'pm'}    = '066';
  $colors{'pod'}   = '096';
  $colors{'t'}     = '099';
  $colors{'html'}  = '00c';
  $colors{'shtml'} = '009';
  $colors{'svg'}   = '60c';
  $colors{'css'}   = '060';
  $colors{'csv'}   = '0f0';
  $colors{'txt'}   = '090';
  $colors{'md'}    = '306';
  $colors{'zip'}   = '990';
  $colors{'js'}    = 'f06';
  $colors{'pdf'}   = 'c33';
  $colors{'wav'}   = '939';
  $colors{'xls'}   = '696';
  $colors{'doc'}   = '669';
  $colors{'pub'}   = '699';
  $colors{'opx'}   = '036';
  $colors{'ods'}   = '3c3';
  $colors{'dot'}   = '3ca';
  $colors{$_}      = 'c0c' for (qw(gif ico jpg png bmp));

  my ($extension,$name) = reverse split(/\./, $file);
  $color = $colors{$extension} ? $colors{$extension} : $color;

  return qq(color:#$color);
}

=pod

=encoding utf8

=head1 NAME

B<Page::Link::Color> returns the hex codes for the color for links to files by their extensions.

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;