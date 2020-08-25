package Page::CGI::Param;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(get_cgi_param);

use HTML::Entities qw(encode_entities);

sub get_cgi_param {
  my ($cgi, $param) = @_;
  my $ret = $cgi->param($param);
  return ($ret ? encode_entities($ret, '<>"') : '');
}

# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;