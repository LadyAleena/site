package Page::People;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(people_list);

use Page::HTML qw(span);
use Page::Sort qw(name_sort);
use Page::Link::External qw(external_links);
use Page::Convert qw(searchify filify);

sub people_list {
  my ($people_file) = @_;

  my $people = undef;
  if (-f $people_file) {
    open(my $fh, '<', $people_file) || die "Can not open $people_file $!";
    my @people_lines = map { chomp; [ split(/\|/, $_) ] } <$fh>;
    close($fh);

    for my $line (sort { name_sort($a->[0], $b->[0]) } @people_lines) {
      my $name = $line->[0];
         $name =~ s/^_//;
      my $article_name = $line->[1] ? $line->[1] : filify($name);
      my $links = external_links([['Wikipedia', $article_name, $name], ['Google', searchify($name), $name]]);
      my $links_text = join(', ', @$links);
      my $link = span("($links_text)", { class => 'links'});
      push @$people, "$name $link";
    }
  }
  return $people;
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;