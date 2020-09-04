package Page::Convert;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Encode;
use Lingua::EN::Inflect qw(NUMWORDS);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(textify idify searchify filify hashtagify linkify);

sub textify {
  my ($text, $opt) = @_;
  my $root_link = $opt->{'root link'} ? $opt->{'root link'} : undef;
  $text = decode('UTF-8', $text) if ($opt->{'decode'} && $opt->{'decode'} =~ /^[ytk1]/);
  $text =~ s/$root_link\/// if $root_link;
  $text =~ s/_/ /g;
  $text =~ s/\b(M[rsx]|Mrs|Dr|St|[SJ]r)\b(?!\.)/$1./g;
  # The following is an more robust version of the preceding, but it is overkill.
  # $text =~ s/(?<!Rev\s)\b(M[rsx]|Mrs|[FPBD]r|Rev|Ven|St|[SJ]r|Esq)\b(?!\.)/$1./g;
  $text =~ s/\s&\s/ &amp; /g;
  $text =~ s/\.{3}/&#8230;/g;
  $text =~ s/(\w|\b|\s|^)'(\w|\b|\s|$)/$1&#700;$2/g;
  $text =~ s/<.+?>//g      unless ($opt->{'html'}   && $opt->{'html'}   =~ /^[ytk1]/);
  $text =~ s/\s\(.*?\)$//  unless ($opt->{'parens'} && $opt->{'parens'} =~ /^[ytk1]/);
  $text =~ s/(.)\.\w{2,5}?$/$1/ unless $text =~ /\w\.(?:com|net|org)$/;
#  $text =~ s/(?<!\A)((?<! )\p{uppercase})/ $1/g; # from Kenosis, kcott, and tye on PerlMonks
  return encode('UTF-8', $text);
}

sub idify {
  my @base = @_;
  my @ids = map {
       s/<.+?>//gr
    =~ s/^(\d+([stnrdh]{2}|))/NUMWORDS($1)/er
    =~ s/(.)\.\w{2,5}?$/$1/r
    =~ s/&amp/and/gr
    =~ s/&/and/gr
    =~ s/Æ/Ae/gr
    =~ s/Ç/C/gr
    =~ s/Ü/U/gr
    =~ s/(è|é|ê)/e/gr
    =~ s/#/No/gr
    =~ s/ /_/gr
    =~ s/[^\w:.\-]//gr
  } grep { defined } @base;
  return encode('UTF-8',join('_',@ids));
}

sub searchify {
  my ($search, $section) = @_;
  $search =~ s/<.+?>//g;
  $search =~ s/(?:_|\s|%20)/+/g;
  $search =~ s/^#/%23/;
  $search =~ s/&/%26/;
  $search =~ s/(.)\.\w{2,5}?$/$1/;
  $search .= '#'.idify(@$section) if $section;
  return $search;
}

sub filify {
  my ($filename) = @_;
  $filename =~ s/<.*?>//g;
  $filename =~ s/[<>:"\/\\|?*\.]//g;
  $filename =~ s/ /_/g;
  return $filename;
}

sub hashtagify {
  my ($hashtag) = @_;
  $hashtag =~ s/<.+?>//g;
  $hashtag =~ s/(.)\.\w{2,5}?$/$1/;
  $hashtag =~ s/&amp/and/g;
  $hashtag =~ s/&/and/g;
  $hashtag =~ s/\W//g;
  $hashtag =~ s/^/#/;
  return $hashtag;
}

sub linkify {
  my ($link) = @_;
  $link =~ s/<.+?>//g;
  $link =~ s/ /_/g;
  return $link;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;