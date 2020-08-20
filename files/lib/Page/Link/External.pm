package Page::Link::External;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(external_link external_links);

use Page::Data qw(make_hash);
use Page::HTML qw(anchor);

my $external_links = make_hash( 'file' => ['Util','external_links.txt'], 'headings' => ['site','base link','after link'] );

sub external_link {
  my ($site, $page_link, $link_title) = @_;

  my $base_link  = $external_links->{$site}{'base link'};
  my $after_link = $external_links->{$site}{'after link'} ? $external_links->{$site}{'after link'} : '';
  my $link = $base_link.$page_link.$after_link;
  my $title = $link_title ? $link_title : undef;

  return anchor($site, { 'href' => "http://$link", 'title' => $title, 'target' => 'ex_tab' });
}

sub external_links {
  my ($links, $class) = @_;

  my @external_links;
  for my $link (@$links) {
    my ($site, $page_link, $title) = @$link;
    next if !$external_links->{$site};
    my $link_title = $site eq 'Google' ? "search Google for $title" : "$title on $site";
    push @external_links, external_link($site, $page_link, $link_title);
  }

  return \@external_links;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;