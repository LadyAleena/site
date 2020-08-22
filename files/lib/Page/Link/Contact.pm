package Page::Link::Contact;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(contact_links);

use Page::Data qw(make_hash);
use Page::HTML qw(anchor img);
use Page::Path qw(base_path);

sub contact_links {
  my $contacts = make_hash( 'file' => ['Util', 'other_sites.txt'] );

  my $root_link = base_path('link');
  my @links;
  for my $link (sort { lc $a cmp lc $b } keys %$contacts) {
    my $address = $contacts->{$link};
    my $title = "Lady Aleena on $link";
    my $image = img({ 'src' => "https://www.google.com/s2/favicons?domain=$address", 'alt' => $title, 'class' => 'contact' });

    push @links, anchor($image, { 'href' => "https://$address", 'target' => 'ex_tab', 'title' => $title });
  }
  push @links, anchor('IRC',   { 'href' => "$root_link?page=irc",     'title' => 'IRC channels I visit' });
  push @links, anchor('Email', { 'href' => 'mailto:fantasy@xecu.net', 'title' => 'E-mail Lady Aleena'   });
  return @links;
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