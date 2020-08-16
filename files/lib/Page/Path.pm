package Page::Path;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(base_path);

my $server = $ENV{SERVER_NAME} ? $ENV{SERVER_NAME} : 'localhost';
my $http   = $ENV{HTTPS} && $ENV{HTTPS} eq 'on' ? 'https' : 'http';

my %hosts = (
  'localhost' => {
    'path' => '/home/me/site',
    'link' => "//localhost",
  },
  'local.doc.www' => {
    'path' => '/home/me/Documents/www',
    'link' => "//local.doc.www",
  },
  'local.site' => {
    'path' => '/home/me/site',
    'link' => "//local.site",
  },
  'fantasy.xecu.net' => {
    'path' => '/home/fantasy/public_html',
    'link' => "//fantasy.xecu.net",
  }
);

my $root_path = $hosts{$server}{'path'};

for my $host (values %hosts) {
  $host->{$_}        = "$root_path/files/$_" for qw(data text);
  $host->{'imagesd'} = "$root_path/files/images";
  $host->{$_}        = $host->{'link'}."/files/$_" for qw(audio css images);
}

sub base_path {
  my ($host_key) = @_;
  return $hosts{$server}{$host_key};
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