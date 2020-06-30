#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Minimal;
use HTML::Entities qw(encode_entities);

use lib 'files/lib';
use Base::Page qw(page story);

my $error_codes;
$error_codes->{300} = 'multiple choices';
$error_codes->{301} = 'moved permanently';
$error_codes->{302} = 'found';
$error_codes->{303} = 'see other';
$error_codes->{304} = 'not modified';
$error_codes->{305} = 'use proxy';
$error_codes->{306} = 'switch proxy';
$error_codes->{307} = 'temporary redirect';
$error_codes->{308} = 'permanent redirect';
$error_codes->{400} = 'bad request';
$error_codes->{401} = 'unautorized';
$error_codes->{402} = 'payment required';
$error_codes->{403} = 'forbidden';
$error_codes->{404} = 'not found';
$error_codes->{405} = 'method not allowed';
$error_codes->{406} = 'not acceptable';
$error_codes->{407} = 'proxy authentication required';
$error_codes->{408} = 'request timeout';
$error_codes->{409} = 'conflict';
$error_codes->{410} = 'gone';
$error_codes->{411} = 'length required';
$error_codes->{412} = 'precondition failed';
$error_codes->{413} = 'payload too large';
$error_codes->{414} = 'URI too long';
$error_codes->{415} = 'unsupported media type';
$error_codes->{416} = 'range not satisfiable';
$error_codes->{417} = 'expectation failed';
$error_codes->{418} = "I'm a teapot";
$error_codes->{421} = 'misdirected request';
$error_codes->{422} = 'unprocessable entity';
$error_codes->{423} = 'locked';
$error_codes->{424} = 'failed dependency';
$error_codes->{425} = 'too early';
$error_codes->{426} = 'upgrade required';
$error_codes->{429} = 'too many requests';
$error_codes->{431} = 'request header fields too large';
$error_codes->{451} = 'unavailable for legal reasons';
$error_codes->{500} = 'internal server error';
$error_codes->{501} = 'not implemented';
$error_codes->{502} = 'bad dateway';
$error_codes->{503} = 'service unavailable';
$error_codes->{504} = 'gateway timeout';
$error_codes->{505} = 'HTTP version not supported';
$error_codes->{506} = 'variant also negotiates';
$error_codes->{507} = 'insufficient storage';
$error_codes->{508} = 'loop detected';
$error_codes->{510} = 'not extended';
$error_codes->{511} = 'netword authentication required';

my $cgi = CGI::Minimal->new;
my $error   = $cgi->param('error') ? encode_entities($cgi->param('error'),'/<>"') : '';

my $error_line = q(You do not have an error here.);
if ($error) {
  $error_line = qq(I am sorry, but your request returned $error (B<$error_codes->{$error}>). Please use the menu to the left to navigate my site. If you like, you can ).q(A<send me an e-mail|href="mailto:fantasy@xecu.net">).qq( to let me know that B<$ENV{REQUEST_URI}> sent you the $error error or go to A<my home page|href="http://fantasy.xecu.net"> and forget this happened.);
}

my $line_magic;
$line_magic->{error_message} = $error_line;

page( 'heading' => "Error $error on Lady Aleena's site", 'uri' => $ENV{REQUEST_URI}, 'code' => sub { story(*DATA, { 'line magic' => $line_magic }) } );

__DATA__
^error_message^