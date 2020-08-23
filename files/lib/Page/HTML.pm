package Page::HTML;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(html style body main div section article nav header footer heading head pre
                 paragraph address anchor img object span blockquote list definition_list table
                 form fieldset selection datalist input inputs textarea figure details noscript);

use Page::Line qw(line);

my @ics  = qw(id class style lang title);
my @java = qw(onclick ondblclick onkeypress onkeydown onkeyup onmouseover onmousedown onmouseup onmousemove onmouseout);
my $gen  = [@ics, @java];

my @boolean_attribute_list = qw(autofocus checked disabled multiple readonly required);
my %boolean_attributes;
$boolean_attributes{$_} = 1 for @boolean_attribute_list;

sub html_attributes {
  my ($valid, $opt) = @_;
  my @attributes;
  for (@{$valid}) {
    my $value = $opt->{$_};
    if ($boolean_attributes{$_}) {
      push @attributes, $_ if defined($opt->{$_});
    }
    else {
      push @attributes, qq($_="$value") if defined($opt->{$_});
    }
  }
  return join(' ', @attributes);
}

# start_tag is used in the following elements:
# plain_element, code_element, img,
# meta, base, links, style, head, paragraph, blockquote,
# item, list, definition, definition_list,
# col, cell, row, thead, tfoot, tbody, table,
# selection, input, fieldset, figure, html
sub start_tag {
  my ($tag, $attributes, $opt) = @_;
  my $tag_attributes = html_attributes($attributes, $opt);
  $tag .= " $tag_attributes" if $tag_attributes;
  $tag .= ' /' if ($opt->{'close'} && $opt->{'close'} =~ /^[yt1]/);
  return "<$tag>";
}

# end_tag is used in the following elements:
# plain_element, code_element, style, head, paragraph, blockquote,
# item, list, definition, definition_list,
# cell, row, thead, tfoot, tbody, table,
# selection, fieldset, figure, html
sub end_tag {
  my ($tag) = @_;
  return "</$tag>";
}

sub break {
  my ($value, $break) = @_;

  my $line = $value;
     $line =~ s/$break/<br>/g;

  return $line;
}

# plain_element is used in the following elements:
# code_element, anchor, span, title, scripts, term, caption, label, option, legend, figcaption, heading
sub plain_element {
  my ($tag, $attributes, $value, $opt) = @_;
  my $start = start_tag($tag, $attributes, $opt);
  my $end   = end_tag($tag);
  my $line  = join('', grep( defined, ($start, $value, $end)));
  return $line;
}

# code_element is used in the following elements:
# body, main, article, section, nav, aside, address, header, footer, div, noscript, form, pre
sub code_element {
  my ($tag, $attributes, $tab, $value, $opt) = @_;

  if (!$value) {
    line($tab, plain_element($tag, $attributes, $value, $opt));
  }
  else {
    line($tab, start_tag($tag, $attributes, $opt));

    $tab++;
    header ($tab, @{$opt->{'header'}})  if ($opt->{'header'}  && $tag !~ /(?:header|footer|address|pre)/);
    heading($tab, @{$opt->{'heading'}}) if ($opt->{'heading'} && $tag !~ /(?:address|pre)/);
    $tab++ if $opt->{'heading'};
    ref($value) eq 'CODE' ? &$value : paragraph($tab + 1, $value, { 'separator' => $opt->{'separator'} });
    $tab-- if $opt->{'heading'};
    footer ($tab, @{$opt->{'footer'}})  if ($opt->{'footer'}  && $tag !~ /(?:header|footer|address|pre)/);
    $tab--;

    line($tab, end_tag($tag));
  }
}

# Start elements

sub img {
  my ($opt) = @_;
  return start_tag('img', ['src', 'alt', @$gen, 'tabindex'], $opt);
}

sub anchor {
  plain_element('a', ['href', 'target', @$gen, 'tabindex'], @_);
}

sub span {
  plain_element('span', $gen, @_);
}

sub object {
  plain_element('object', ['type', 'data', 'width', 'height', @$gen], @_);
}

# Start elements for head.

sub title {
  my $tab = shift;
  line($tab, plain_element('title', undef, @_));
}

sub meta {
  my ($tab, $metas) = @_;
  for (@$metas) {
    line($tab, start_tag('meta', ['name', 'http-equiv', 'lang', 'content', 'charset'], $_));
  }
}

sub base {
  my ($tab, $opt) = @_;
  line($tab, start_tag('base', ['href', 'target'], $opt));
}

sub links {
  my ($tab, $links) = @_;
  for (@$links) {
    line($tab, start_tag('link', ['rel', 'rev', 'type', 'href', 'title'], $_));
  }
}

sub scripts {
  my ($tab, $scripts) = @_;
  line($tab, plain_element('script', ['type', 'src'], '', $_)) for @$scripts;
}

sub noscript {
  code_element('noscript', $gen, @_);
}

sub style {
  my ($tab, $value, $opt) = @_;
  my $tag = 'style';

  my $sep = $opt->{'separator'} ? $opt->{'separator'} : "\n";

  line($tab, start_tag($tag, ['type'], $opt));
  for (grep(length, split(/$sep/, $value))) {
    $_ =~ s/^\s+//;
    line($tab + 1, $_);
  }
  line($tab, end_tag($tag));
}

sub head {
  my ($tab, $opt) = @_;
  my $tag = 'head';

  line($tab, start_tag($tag, ['profile'], $opt));

  $tab++;
    title   ($tab,   $opt->{'title'});
    base    ($tab,   $opt->{'base'})     if $opt->{'base'};
    meta    ($tab,   $opt->{'meta'})     if $opt->{'meta'};
    links   ($tab,   $opt->{'links'})    if $opt->{'links'};
    scripts ($tab,   $opt->{'scripts'})  if $opt->{'scripts'};
    style   ($tab, @{$opt->{'style'}})   if $opt->{'style'};
    noscript($tab,   $opt->{'noscript'}) if $opt->{'noscript'};
  $tab--;

  line($tab, end_tag($tag));
}

# End elements for head.
# Begin elements for body.

# Begin paragraphs

sub paragraph {
  my ($tab, $value, $opt) = @_;
  my $tag = 'p';
  my $sep = $opt->{'separator'} ? $opt->{'separator'} : "\n";

  for (grep(length, split(/$sep/, $value))) {
    my $paragraph = $opt->{'break'} ? break($_, $opt->{'break'}) : $_;
       $paragraph =~ s/^\s+//;
    line($tab, start_tag($tag, $gen, $opt));
    line($tab + 1, $paragraph);
    line($tab, end_tag($tag));
  }
}

# End paragraphs
# Begin blockquotes

sub blockquote {
  my ($tab, $value, $opt) = @_;
  my $tag = 'blockquote';

  line($tab, start_tag($tag, ['value', @$gen], $opt));
  paragraph($tab + 1, $value);
  line($tab, end_tag($tag));
}

# End blockquotes
# Begin elements for ordered and unordered lists.

sub item {
  my ($tab, $value, $opt) = @_;
  my $tag = 'li';

  line($tab, start_tag($tag, ['value', @$gen], $opt));
  line($tab + 1, $value);
  if ($opt->{inlist}) {
    list($tab + 1, @{$opt->{'inlist'}});
  }
  line($tab, end_tag($tag));
}

sub list {
  my ($tab, $type, $list, $opt) = @_;
  my $tag = $type.'l';

  line($tab, start_tag($tag, [@$gen, 'start'], $opt));
  for my $item (@$list) {
    if (ref($item) eq 'ARRAY') {
      item($tab + 1, $item->[0], $item->[1]);
    }
    else {
      item($tab + 1, $item);
    }
  }
  line($tab, end_tag($tag));
}

# End elements for ordered and unordered lists.
# Begin elements for definition lists.

sub term {
  my $tab = shift;
  line($tab, plain_element('dt', $gen, @_));
}

sub definition {
  my ($tab, $value, $opt) = @_;
  my $tag = 'dd';

  line($tab, start_tag($tag, $gen, $opt));
  line($tab + 1, $value);
  line($tab, end_tag($tag));
}

sub definition_list {
  my ($tab, $definition_list, $opt) = @_;
  my $tag = 'dl';

  line($tab, start_tag($tag, $gen, $opt));
  for my $item (@$definition_list) {
    if ($item->{'term'}) {
      my $term = $item->{'term'};
      if (ref($term) eq 'ARRAY') {
        term($tab + 1, @$term);
      }
      else {
        term($tab + 1, $term);
      }
    }

    if ($item->{'terms'}) {
      my $terms = $item->{'terms'};
      for my $term (@{$terms}) {
        if (ref($term) eq 'ARRAY') {
          term($tab + 1, @$term);
        }
        else {
          term($tab + 1, $term);
        }
      }
    }

    if ($item->{'definition'}) {
      my $definition = $item->{'definition'};
      if (ref($definition) eq 'ARRAY') {
        definition($tab + 2, @$definition);
      }
      else {
        definition($tab + 2, $definition);
      }
    }

    if ($item->{'definitions'}) {
      my $definitions = $item->{'definitions'};
      for my $definition (@{$definitions}) {
        if (ref($definition) eq 'ARRAY') {
          definition($tab + 1, @$definition);
        }
        else {
          definition($tab + 1, $definition);
        }
      }
    }

    if ($opt->{'headings'}) {
      my $headings = $opt->{'headings'};
      for my $heading (@$headings) {
        my $upheading = ucfirst $heading;
        my $span_class = $opt->{'span class'} ? $opt->{'span class'} : undef;
        my $span = span("$upheading: ", { 'class' => $span_class });

        definition($tab + 2, $span.$item->{$heading});
      }
    }
  }
  line($tab, end_tag($tag));
}

# End elements for definition lists.
# Begin elements for tables.

sub caption {
  my $tab = shift;
  line($tab, plain_element('caption', ['align', @$gen], @_));
}

sub col {
  my ($tab, $opt) = @_;
  line($tab, start_tag('col', ['span', @$gen], $opt));
}

sub cell {
  my ($tab, $type, $value, $opt) = @_;
  $type = $opt->{'type_override'} ? $opt->{'type_override'} : $type;
  my $tag = 't'.$type;
  my $start_tag = start_tag($tag, ['colspan', 'rowspan', @$gen], $opt);
  my $end_tag   = end_tag($tag);
  $value = '&nbsp' if !$value;

  if ($value eq 'list') {
    line($tab, $start_tag);
    list($tab + 1, @{$opt->{'list'}});
    line($tab, $end_tag);
  }
  else {
    line($tab + 1, $start_tag.$value.$end_tag);
  }
}

sub row {
  my ($tab, $type, $cells, $opt) = @_;
  my $tag = 'tr';

  my %types = (
    'header' => 'h',
    'data'   => 'd',
    'whead'  => 'd'
  );

  line($tab, start_tag($tag, $gen, $opt));

  if ($type eq 'whead') {
    my $cell = shift @{$cells};
    if (ref($cell) eq 'ARRAY') {
      cell($tab + 1, 'h', ucfirst $cell->[0], { 'class' => 'row_header', %{$cell->[1]} });
    }
    else {
      cell($tab + 1, 'h' , ucfirst $cell, { 'class' => 'row_header' });
    }
  }

  my $cell_type = $types{$type};
  for my $cell (@{$cells}) {
    if (ref($cell) eq 'ARRAY') {
      cell($tab + 1, $cell_type, $cell->[0], $cell->[1]);
    }
    else {
      cell($tab + 1, $cell_type, $cell);
    }
  }

  line($tab, end_tag($tag));
}

sub rows {
  my ($tab, $rows) = @_;
  for my $rowgroup (@$rows) {
    my $type = $rowgroup->[0];
    my @rows = $rowgroup->[1];
    my $attributes = $rowgroup->[2];

    for my $row (@rows) {
      row($tab, $type , $_, $attributes) for @$row;
    }
  }
}

sub thead {
  my ($tab, $opt) = @_;
  my $tag = 'thead';

  return if !$opt->{'rows'};

  line($tab, start_tag($tag, $gen, $opt));
  rows($tab + 1, $opt->{'rows'});
  line($tab, end_tag($tag));
}

sub tfoot {
  my ($tab, $opt) = @_;
  my $tag = 'tfoot';

  return if !$opt->{'rows'};

  line($tab, start_tag($tag, $gen, $opt));
  rows($tab + 1, $opt->{'rows'});
  line($tab, end_tag($tag));
}

sub tbody {
  my ($tab, $opt) = @_;
  my $tag = 'tbody';

  return if !$opt->{'rows'};

  line($tab, start_tag($tag, $gen, $opt));
  rows($tab + 1, $opt->{'rows'});
  line($tab, end_tag($tag));
}

sub table {
  my ($tab, $opt) = @_;
  my $tag = 'table';

  line($tab, start_tag($tag, $gen, $opt));

  $tab++;
  if ($opt->{'caption'}) {
    if (ref($opt->{'caption'}) eq 'ARRAY') {
      caption($tab, $opt->{'caption'}->[0], $opt->{'caption'}->[1]);
    }
    else {
      caption($tab, $opt->{'caption'});
    }
  }

  if ($opt->{'cols'}) {
    col($tab, $_) for @{$opt->{'cols'}};
  }

  thead($tab, $opt->{'thead'}) if $opt->{'thead'};
  tfoot($tab, $opt->{'tfoot'}) if $opt->{'tfoot'};
  if ($opt->{'tbody'}) {
    tbody($tab, $_) for @{$opt->{'tbody'}};
  }
  else {
    tbody($tab, { 'rows' => $opt->{'rows'} });
  }
  $tab--;

  line($tab, end_tag($tag));
}

# End elements for tables.
# Begin elements for forms.

sub label {
  my $tab = shift;
  line($tab, plain_element('label', ['for', @$gen], @_));
}

sub option {
  my $tab = shift;
  line($tab, plain_element('option', ['value', @$gen], @_));
}

sub selection {
  my ($tab, $options, $opt) = @_;
  my $tag = 'select';

  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'before');
  line($tab, start_tag($tag, ['name', 'multiple', @$gen, 'tabindex'], $opt));
  for (@$options) {
    option($tab + 1, @$_);
  }
  line($tab, end_tag($tag));
  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'after');
}

sub datalist {
  my ($tab, $options, $opt) = @_;
  my $tag = 'datalist';

  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'before');
  line($tab, start_tag($tag, ['name', 'multiple', @$gen, 'tabindex'], $opt));
  for (@$options) {
    option($tab + 1, @$_);
  }
  line($tab, end_tag($tag));
  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'after');
}

sub textarea {
  my ($tab, $value, $opt) = @_;

  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'before');
  line($tab, plain_element('textarea', ['name', 'rows', 'cols', @$gen, 'tabindex'], ($value, $opt)));
  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'after');
}

sub input {
  my ($tab, $opt) = @_;
  my $tag = 'input';
  my @input_attributes = qw(type name value placeholder list form accept alt capture files
                            min max minlength maxlength size width height
                            multiple namepattern pattern
                            spellcheck src step inputmode
                            formaction formenctype formmethod formnovalidate formtarget
                            selectionDirection selectionStart selectionEnd
                            valueAsDate valueAsNumber
                            autocomplete autofocus accesskey
                            disabled readonly required checked);
  $opt->{close} = 'yes';
  my $start = start_tag($tag, [@input_attributes, @$gen, 'tabindex'], $opt);

  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'before');
  line($tab, $start);
  label($tab, @{$opt->{'label'}}) if ($opt->{'label'} && $opt->{'place label'} eq 'after');
}

sub inputs {
  my ($tab, $inputs) = @_;
  input($tab, $_) for @$inputs;
}

sub legend {
  my $tab = shift;
  line($tab, plain_element('legend', $gen, @_));
}

sub fieldset {
  my ($tab, $code, $opt) = @_;
  my $tag = 'fieldset';

  line($tab, start_tag($tag, $gen, $opt));
    legend($tab, $opt->{'legend'}) if $opt->{'legend'};
    &$code;
  line($tab, end_tag($tag));
}

sub form {
  code_element('form', ['action', 'method', @$gen], @_);
}

# End elements for forms.
# Start figure elements.

sub figcaption {
  my $tab = shift;
  line($tab, plain_element('figcaption', $gen, @_));
}

sub figure {
  my ($tab, $code, $opt) = @_;
  my $tag = 'figure';

  line($tab, start_tag($tag, $gen, $opt));
  figcaption($tab + 1, @{$opt->{'figcaption'}}) if ($opt->{'figcaption'} && $opt->{'place caption'} eq 'before');
  &$code;
  figcaption($tab + 1, @{$opt->{'figcaption'}}) if ($opt->{'figcaption'} && $opt->{'place caption'} eq 'after');
  line($tab, end_tag($tag));
}


# End figure elements.
# Start details element.

sub summary {
  my $tab = shift;
  line($tab, plain_element('summary', $gen, @_));
}

sub details {
  my ($tab, $code, $opt) = @_;
  my $tag = 'details';

  line($tab, start_tag($tag, ['open', @$gen], $opt));
  summary($tab + 1, $opt->{'summary'}) if $opt->{'summary'};
  &$code;
  line($tab, end_tag($tag));
}

# End details element.
# Start general elements.

sub heading {
  my ($tab, $level, $value, $opt) = @_;
  my $tag = 'h'.$level;
  line($tab, plain_element($tag, $gen, $value, $opt));
}

sub pre     { code_element('pre',     $gen, @_) }
sub div     { code_element('div',     $gen, @_) }
sub header  { code_element('header',  $gen, @_) }
sub footer  { code_element('footer',  $gen, @_) }
sub address { code_element('address', $gen, @_) }
sub aside   { code_element('aside',   $gen, @_) }
sub nav     { code_element('nav',     $gen, @_) }
sub section { code_element('section', $gen, @_) }
sub article { code_element('article', $gen, @_) }
sub main    { code_element('main',    $gen, @_) }
sub body    { code_element('body',    $gen, @_) }

# End general elements.
# End elements for body.

sub html {
  my ($tab, $opt) = @_;
  my $tag = 'html';

  print "Content-Type: text/html; charset=utf-8 \n\n";
  line(0, $opt->{'doctype'} ? $opt->{'doctype'} : '<!DOCTYPE html>');
  line($tab, start_tag($tag, $gen, $opt));
  head($tab + 1, $opt->{'head'})    if $opt->{'head'};
  body($tab + 1, @{$opt->{'body'}}) if $opt->{'body'};
  line($tab, end_tag($tag));
}

# End elements

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena with a lot of help from the L<PerlMonks|http://www.perlmonks.org>.

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<<aleena@cpan.org>>. All rights reserved.

=cut

1;