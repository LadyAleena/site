package Page::Menu;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(base_menu alpha_menu index_menu);

use Cwd qw(cwd realpath);

use HTML::Elements qw(anchor);
use Page::List::File  qw(file_list);
use Page::Link::Color qw(link_color);
use Util::Convert  qw(textify searchify);
use Util::Sort     qw(article_sort name_sort);

# base_menu is the site's navigation menu on the left side of the pages
sub base_menu {
  my ($directory, $opt) = @_;
  my $root_path = $opt->{'root path'};
  my $full_path = $opt->{'full path'};
  my $curr_cwd = cwd;

  my $sort = $directory =~ /(Other_poets|Player_characters|Spellbooks)$/ ? \&name_sort : \&article_sort; # Thank you [davido]!

  my (@files, @directories);

  if (!$opt->{'full'} || $opt->{'full'} !~ /^[yt1]/) {
    my $text_dir = $directory;
       $text_dir =~ s|(\Q$root_path\E)|$1/files/text|;
    my @text_files = -e $text_dir ? sort { $sort->($a, $b, { 'misc' => $opt->{'misc'} }) } file_list($text_dir, { 'uppercase' => 1 }) : undef;
    for my $text_file (@text_files) {
      my $text   = textify($text_file);
      my $select = searchify($text_file);
      my $link   = File::Spec->abs2rel("$directory/index.pl?page=$select", $full_path);
      my $class  = $opt->{'selected'} && $opt->{'selected'} eq $text ? 'active' : 'inactive';
      my $anchor = anchor($text, { 'href' => $link, 'title' => $text});
      push @files, [$anchor, { 'class' => $class }] if -f "$text_dir/$text_file";
    }
  }

  my @contents = file_list($directory, { 'uppercase' => (!$opt->{'full'} || $opt->{'full'} !~ /^[yt1]/) ? 1 : 0 });
     @contents = sort { $sort->($a, $b, { 'misc' => $opt->{'misc'} }) } @contents; # Thank you [davido]!

  for my $content (@contents) {
    my $long_content = "$directory/$content";
    my $link = File::Spec->abs2rel($long_content, $full_path);
    my $text = $content !~ /^\./ ? textify($content) : $content;

    if (-f $long_content) {
      my $class  = realpath($0) eq $long_content ? 'active' : 'inactive';
      my $color  = $opt->{'color'} == 1 ? link_color($content,1) : undef;
      my $inlist = $class eq 'active' && $opt->{'file menu'} ? ['u', $opt->{'file menu'}, { 'class' => 'sub_menu' }] : undef;
         $class .= $class eq 'active' && $opt->{'file menu'} ? ' open' : '';
      if (-M $long_content < 3) {
        $class  .= ' updated';
      }
      my $anchor = anchor($text, { 'href' => $link, 'title' => $text, 'style' => $color });
      push @files, [$anchor, { 'class' => $class, 'inlist' => $inlist }];
    }

    if (-d $long_content) {
      my $class = $curr_cwd =~ /$long_content/ ? 'open active' : 'closed inactive';
      my $index = "$long_content/index.pl";
      my $file_list;
      my $anchor;

      if (-e $index && (!$opt->{'full'} || $opt->{'full'} !~ /^[yt1]/)) {
        $link     .= "/index.pl";
        my $color  = $opt->{'color'} == 1 ? link_color($link,1) : undef;
        $anchor    = anchor($text, { 'href' => $link, 'title' => $text, 'style' => $color });
        $file_list = "$curr_cwd/$0" =~ /$index/ && $class =~ / active$/ && $opt->{'file menu'} ? $opt->{'file menu'} : undef;
      }

      my $next_list = $text !~ /^\./ ? base_menu($long_content, $opt) : undef;
      push @$next_list, @$file_list if $file_list;
      my $inlist = $next_list ? ['u', $next_list] : undef;
      $class =~ s/^(?:open|closed) // if !$inlist;
      push @directories, [$anchor ? $anchor : $text, { 'class' => $class, 'inlist' => $inlist}];
    }
  }
  if (@files > 1) {
    @files = sort { $sort->(textify($a->[0], { 'decode' => 1 }), textify($b->[0], { 'decode' => 1 })) } @files;
  }
  my @file_lines = (@files, @directories);

  return @file_lines > 0 ? \@file_lines : undef;
}

# index_munu returns a list of links of the files in the directory entered.
sub index_menu {
  my $dir = shift;
  my @file_list = file_list($dir);
  my $files = [
    map  { anchor( textify($_), { href => $_ } ) }
    sort { article_sort($a, $b) }
    grep { /^\p{uppercase}/ &&  -f $_ }
    @file_list
  ];
  return $files;
}

# alpha_menu returns a string of links based on keys of a hash.
sub alpha_menu {
  my ($hash, $opt) = @_;

  my @line;
  for my $letter (sort { $a cmp $b } keys %{$hash}) {
    my $parameter    = $opt->{'param'} ? $opt->{'param'} : undef;
    my $section_name = $letter eq uc($letter) ? $letter : "l$letter";
    my $href         = $parameter ? "?$parameter=".searchify($section_name) : "#section_$section_name";
    push @line, anchor("&nbsp;$letter&nbsp;", { 'href' => $href });
  }

  if ($opt->{'addition'}) {
    push @line, ref($opt->{'addition'}) eq 'ARRAY' ? @{$opt->{'addition'}} : $opt->{'addition'};
  }

  my $join = $opt->{'join'} ? $opt->{'join'} : ', ';
  my $line = $opt->{'join'} ? join($join, @line) : \@line;

  return $line;
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