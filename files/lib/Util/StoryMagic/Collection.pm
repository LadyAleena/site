package Util::StoryMagic::Collection;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(collection_magic);

use HTML::Elements qw(list);
use Util::People qw(people_list);

sub media_class {
  my ($class, $title) = @_;
  my $add_title = $title && $title =~ /^[yt1]/ ? 'title ' : '';
  return qq(class="$add_title$class");
}

sub collection_magic {
  my $magic;

  for (qw(massmarket trade hardcover cd cassette lp ff brd dvd vhs dgt)) {
    $magic->{"${_}s"} = media_class($_);
    $magic->{$_}      = media_class($_, 'yes');
  }

  my @people = (qw(authors musicians comedians artists), 'actors in films', 'producers and directors');
  for my $group (@people) {
    my $file = ucfirst "$group.txt";
       $file =~ s/ /_/g;
    $magic->{$group} = sub { list(3, 'u', people_list($file), { 'class' => 'three' }) };
  }

  return $magic;
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