package Page::People;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(people_list);

use Page::File qw(file_path);
use Page::HTML qw(span);
use Util::Convert qw(filify searchify);
use Util::Sort qw(name_sort);
use Page::Link::External qw(external_links);

sub people_list {
  my ($file) = @_;

  my $people_file = file_path('People', $file);
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

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;