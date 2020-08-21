package Page::Story;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(story passage convert_string);

use CGI::Carp qw(fatalsToBrowser);
use List::Util qw(max);

use Page::HTML qw(nav section heading paragraph blockquote list table  pre anchor   );
use Page::Line qw(line);
use Page::Link::External qw(external_links);
use Page::Story::Inline  qw(inline);
use Fancy::Join::Grammatical qw(grammatical_join);
use Util::Convert  qw(idify textify searchify);
use Util::Columns  qw(number_of_columns);

# Start the story

sub story {
  my ($source, $opt) = @_;

  my $d_source = dissect_source($source);
  my $cols     = $d_source->{'cols'};
  my $toc      = $d_source->{'toc'};
  my $sections = $d_source->{'sections'};

  my $tab = 2;
  my $inc = 0;
  for my $section (@$sections) {
    section($tab + 1, sub { passage($tab + 2, $section, $opt) }, { 'class' => 'content' }) if $section;

    if ($inc == 0 && $cols > 3) {
      nav($tab + 1, sub {
        my $class = number_of_columns(4, $cols, 1);
        list($tab + 2, 'u', $toc, { 'class' => $class });
      }, { 'heading' => [2, 'Table of contents'], 'class' => 'contents'} );
    }
    $inc++;
  }
}

# Start dissecting the source

sub dissect_source {
  my ($source) = @_;

  my $inc = 0;
  my $cols = 0;
  my @sections;
  my @toc;

  while (my $line = <$source>) {
    chomp $line;
    next if !$line;

    if ($line =~ /^2 /) {
      my ($number, $text) = split(/ /, $line, 2);
      $text =~ s/ \+$//;
      push @toc, [anchor(textify($text, { 'decode' => 1 }), { 'href' => '#'.idify($text) })];
    }
    if ($line =~ /^3 /) {
      my ($number,$text) = split(/ /, $line, 2);
      $text =~ s/ \+$//;
      $toc[$inc-1][1]->{inlist}[0] = 'u';
      push @{$toc[$inc-1][1]->{inlist}[1]}, anchor(textify($text, { 'decode' => 1 }), { 'href' => '#'.idify($text) });
    }

    $inc++  if $line =~ /^2 /;
    $cols++ if $line =~ /^(?:2|3) /;

    push @{$sections[$inc]}, $line;
  }
  push @toc, [anchor('Comments', { 'href' => '#Comments' })];

  return { 'cols' => $cols, 'toc' => \@toc, 'sections' => \@sections };
}

# End dissecting the source
# Start passage

sub passage {
  my ($tab, $section, $opt) = @_;
  my $match = ':\*#|';

  for (my $lineno = 0; $lineno < @$section; $lineno++) {
    my $line = $section->[$lineno];
    if ($line =~ /^[$match]/) {
      $match = substr($line, 0, 1);

      my $start = $lineno;
      my $end   = $lineno;
      $end++ while ($end < $#$section and $section->[$end+1] =~ /^[$match]/);

      my @list_lines = @{$section}[$start..$end];

      $tab++;
      if ($match eq ':') {
        my $class = $list_lines[0] =~ s/^:\| (.+)$/$1/ ? shift @list_lines : undef;
        pre($tab, sub { print join("\n", map(substr($_, 2), @list_lines)) }, { 'class' => $class });
      }
      elsif ($match eq '|') {
        my @list = map { s/^\|(.+)/$1/r } @list_lines;
        my $opts = table_opts(\@list, $opt);
        table($tab, $opts);
      }
      else {
        my $class = $list_lines[0] =~ s/^[\*#]\| (.+)$/$1/ ? shift @list_lines : undef;
        my @list = list_opts(\@list_lines, $opt);
        $list[0][2]->{'class'} = $class ? $class : undef;
        list($tab, @{$list[0]});
      }
      $tab--;

      $lineno = $end;
      $match = ':\*#|';
    }
    else {
      heading_w_links($tab, $1, $2), next if $line =~ /^([1-6])\s+(.+) \+$/;
      heading($tab, $1, textify($2, { 'decode' => 1, 'html' => 1 }), { 'id' => idify($2) }), next if $line =~ /^([1-6])\s+(.+)/;
      heading($tab, $1, textify($2, { 'decode' => 1, 'html' => 1 }), { 'id' => idify($2), class => "noclear" }), next if $line =~ /^([1-6])n\s+(.+)/;

      $tab++;
      $opt->{'doc magic'}->{$1}->(), next if $line =~ /^&\s+(.+)/;
      line($tab, $line),             next if $line =~ /^<.+>/;
      line($tab, "<$line>"),         next if $line =~ /^[bh]r$/;
      blockquote($tab, inline(convert_string($1, $opt->{'line magic'}))),  next if $line =~ /^bq\s(.+)/;
      # paragraphs
      paragraph($tab, inline(convert_string($1,    $opt->{'line magic'})), { 'class' => 'stanza', 'break' => '\|' }), next if $line =~ /^stanza (.+)$/;
      paragraph($tab, inline(convert_string($2,    $opt->{'line magic'})), { 'class' => sprintf "indent_%02s", $1}),  next if $line =~ /^\>(\d+) (.+)$/;
      paragraph($tab, inline(convert_string($line, $opt->{'line magic'})), { 'class' => 'author' }),                  next if $line =~ /^(?:by|with|from|as) /;
      paragraph($tab, inline(convert_string($line, $opt->{'line magic'})));
      $tab--;
    }
  }
}

# Start tables
# Start the options to create tables
# |# is the id
# || is the class(es)
# |! is the caption
# |^ is headings put into thead
# |= is footings put into tfoot
# |* is rows that are all heading
# |+ is rows starting with head
# |- is a normal row

sub table_opts {
  my ($lines, $opt) = @_;
  my $table_opts;

  my $match = '#|!*=+-';
  for (my $lineno = 0; $lineno < @$lines; $lineno++) {
    my $line = $lines->[$lineno];
    $match = substr($line, 0, 1);

    if ($match eq '#') {
      $line =~ s/^# (.+)$/$1/;
      $table_opts->{'id'} = $line;
    }
    elsif ($match eq '|') {
      $line =~ s/^\| (.+)$/$1/;
      $table_opts->{'class'} = $line;
    }
    elsif ($match eq '!') {
      $line =~ s/^\! (.+)$/$1/;
      $table_opts->{'caption'} = inline(convert_string($line), $opt->{'line magic'});
    }
    elsif ($match eq '^') {
      my $thead_start = $lineno;
      my $thead_end   = $lineno;
      $thead_end++ while ($thead_end < $#$lines and $lines->[$thead_end + 1] eq '^');

      my @table_rows = map {
        row_line($_, $opt);
      } @{$lines}[$thead_start..$thead_end];

      push @{$table_opts->{'thead'}->{'rows'}}, ['header', \@table_rows];

      $lineno = $thead_end;
    }
    elsif ($match eq '=') {
      my $tfoot_start = $lineno;
      my $tfoot_end   = $lineno;
      $tfoot_end++ while ($tfoot_end < $#$lines and $lines->[$tfoot_end + 1] eq '=');

      my @table_rows = map {
        row_line($_, $opt);
      } @{$lines}[$tfoot_start..$tfoot_end];

      push @{$table_opts->{'tfoot'}->{'rows'}}, ['whead', \@table_rows];

      $lineno = $tfoot_end;
    }
    elsif ($match =~ /[\*\+-]/) {
      my $row_start = $lineno;
      my $row_end   = $lineno;
      $row_end++ while ($row_end < $#$lines and $lines->[$row_end + 1] =~ /^[$match]/);

      my @table_rows = map {
        row_line($_, $opt);
      } @{$lines}[$row_start..$row_end];

      my $type = $match =~ /\*/ ? 'header' :
                 $match =~ /\+/ ? 'whead'  :
                 'data';
      push @{$table_opts->{'rows'}}, [$type, \@table_rows];

      $lineno = $row_end;
    }
    $match = '^=*+-';
  }

  return $table_opts;
}

# End the options to create tables

sub row_line {
  my ($line, $opt) = @_;
  $line =~ s/^[\*\+-] (.+)/$1/;
  my @row = split(/\|/, $line);
  my $row_data;
  for my $cell (@row) {
    push @{$row_data}, $cell =~ /^r(\d+)\s(.+)$/ ? [inline(convert_string($2, $opt->{'line magic'})), { 'rowspan' => $1 }] :
                       $cell =~ /^c(\d+)\s(.+)$/ ? [inline(convert_string($2, $opt->{'line magic'})), { 'colspan' => $1 }] :
                       $cell && length $cell     ?  inline(convert_string($cell, $opt->{'line magic'})) : '&nbsp';
  }
  return $row_data;
}

# End tables
# Start lists
# list_type and list_opts are written by [hdb].
# [ig] wrote a version too.

sub list_type {
  my %type = ( '*' => 'u', '#' => 'o' );
  return $type{ substr shift, -1 }
}

sub list_opts {
  my ($list, $opt) = @_;
  $list     = [ map (inline(convert_string($_, $opt->{'line magic'})), @$list) ];

  my @lines = map {
    /([*#]*)(\d*)\s+(.*)/;
    $2 ? [$1, [$3, {value => $2}]] : [$1, $3]
  } @$list;
  my $maxlevel = max map { length $_->[0] } @lines;

  while( $maxlevel ) {
    my @indices = grep { $maxlevel == length $lines[$_]->[0] } 0..@lines - 1;
    while( @indices ) {
      my $end = pop @indices;
      my $start = $end;
      $start = pop @indices while @indices and $indices[-1] == $start-1;
      my $sublist = [
        list_type($lines[$start]->[0]),
        [ map { $_->[1] } splice @lines, $start, $end-$start + 1 ]
      ];
      $lines[$start-1]->[1] = [ $lines[$start-1]->[1], { 'inlist' => $sublist } ] if $maxlevel > 1;
      splice @lines, $start, 0, $sublist if $maxlevel == 1;
    }
    $maxlevel--;
  }
  @lines = grep { $_->[0] } @lines;

  return @lines;
}

# End lists
# Start headings with links

sub heading_w_links {
  my ($tab, $level, $text) = @_;
  my ($heading, $wikipedia) = split(/\|/,$text);
  my $article = $wikipedia ? $wikipedia : $heading;
  my $links = external_links([['Wikipedia', $article, $article], ['Google', searchify($article), $article]]);
  my $links_text = grammatical_join('or', @$links);

  heading($tab, $level, textify($heading), { 'id' => idify($heading), 'class' => 'wlinks' });
  paragraph($tab + 1, "See more about $article on $links_text.", { 'class' => 'heading_links' } );
}

# End headings with links
# Start converting strings

sub convert_string {
  my ($string, $line_magic) = @_;
  $string =~ s/\^(.+?)\^/exists $line_magic->{$1} ? $line_magic->{$1} : $1/ge;
  return $string;
}

# End converting strings
# End passage
# End story

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut
