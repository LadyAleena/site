#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use CGI::Simple;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Entities qw(encode_entities);

use lib '../../files/lib';
use Page::Base qw(page);
use Page::Data qw(make_hash);
use Page::HTML qw(section paragraph table anchor);
use Page::CGI::Param qw(get_cgi_param);
use Page::Forms qw(tiny_select);
use Page::File qw(file_directory);
use Util::Convert  qw(idify);

my $cgi = CGI::Simple->new;
my $alpha   = get_cgi_param($cgi, 'alpha');
my @classes = $cgi->param('class') ? $cgi->param('class') : ''; # can't encode entities or array won't work.
my $slots   = get_cgi_param($cgi, 'slots');
my $ability = get_cgi_param($cgi, 'rel_ability');

my @headings = ('Proficiency', 'Slots', 'RA', 'CM', 'Class(es)', 'Sources');

my $ref_dir = file_directory('Role_playing/Reference_tables');

my $proficiencies = make_hash( 'file' => "$ref_dir/Proficiencies.txt", 'headings' => \@headings );
my $references    = make_hash( 'file' => "$ref_dir/References.txt" );

sub markupbooks {
  my ($abbr) = @_;
  my $title = $references->{$abbr};
  return qq{$title};
}

my @rows;
my $class = join('|',@classes);
for my $proficiency (sort { $a->{'Proficiency'} cmp $b->{'Proficiency'} } values %$proficiencies) {
  next if $alpha   && $proficiency->{'Proficiency'} !~ /^$alpha/;
  next if $class   && $proficiency->{'Class(es)'}   !~ /(?:$class|all)/;
  next if $ability && ($proficiency->{'RA'} && $proficiency->{'RA'} ne $ability);
  next if $slots   && $proficiency->{'Slots'}       ne $slots;

  my $id = idify($proficiency->{'Proficiency'});
  my @sources        = map(markupbooks($_), split(/;/,$proficiency->{'Sources'}));
  my $sources_plural = @sources > 1 ? 'Sources' : 'Source';

  my $contents = {
    'Proficiency' => $proficiency->{'Proficiency'}, # anchor($proficiency->{'Proficiency'}, { href => "proficiency_descriptions.pl#$id" }),
    'Sources' => anchor($sources_plural, { class => 'sources', title => "$sources_plural:&#10".join(',&#10;', (@sources)) }),
    'Class(es)' => join(', ',split(/;/,$proficiency->{'Class(es)'})),
  };

  my @row;
  for my $heading (@headings) {
    my $content = $contents->{$heading} ? $contents->{$heading} : $proficiency->{$heading};
    push @row, $content ? $content : '';
  }

  push @rows, \@row;
}

page( 'code' => sub {
  section(3, sub {
    paragraph(4,qq{These proficiencies are from Advanced Dungeons and Dragons, 2nd edition. You can select the proficiencies you wish to view. Please see the source books for the descriptions. If you know of more, please email me.});
  });
  tiny_select(4, {
    'class'    => 'proficiency',
    'location' => 'Proficiencies.pl',
    'file'     => "$ref_dir/Proficiences_select.txt",
    'order'    => ['alpha', 'slots', 'rel_ability', 'class']
   });
  section(3, sub {
    table(4, {
      'class' => 'proficiency',
      'thead' => { 'rows' => [['header',[\@headings]]]},
      'rows'  => [['data',\@rows]]
    });
  }, { 'class' => 'rp_table' });
});