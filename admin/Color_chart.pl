#!/usr/bin/perl
use strict;
use warnings FATAL => qw( all );

use lib '../files/lib';
use Page::Base     qw(page);
use Page::Story    qw(story);
use HTML::Elements qw(table);

sub color_opts {
  my ($color, $class, $rowspan, $colspan) = @_;
  my $hash;
  $hash->{'style'} = "background-color:#$color;" if $color;
  $hash->{'class'} = $class if $class;
  $hash->{'rowspan'} = $rowspan if $rowspan;
  $hash->{'colspan'} = $colspan if $colspan;
  return [$color, $hash];
}

my $rows = [
  map [ map color_opts(@$_), @$_ ],
  [ ['330000', 'dark', '5'], ['660033', 'dark', '2'], ['990033', 'dark', '2'], ['cc0066', 'dark'],      ['ff0066'],          ['ff3399'],          ['ff6699', '', '2'], ['ff99cc', '', '2'], ['ffcccc', '', '5'] ],
  [                                                                            ['cc0033', 'dark'],      ['ff0033'],          ['ff3366'] ],
  [                          ['660000', 'dark'],      ['990000', 'dark'],      ['cc0000', 'dark'],      ['ff0000', 'prime'], ['ff3333'],          ['ff6666'],          ['ff9999'] ],
  [                          ['663300', 'dark', '4'], ['993300', 'dark', '2'], ['cc3300', 'dark'],      ['ff3300'],          ['ff6633'],          ['ff9966', '', '2'], ['ffcc99', '', '4'] ],
  [                                                                            ['cc6600', 'dark', '2'], ['ff6600'],          ['ff9933', '', '2'] ],
  [ ['333300', 'dark', '5'],                          ['996600', 'dark', '2'],                          ['ff9900'],                               ['ffcc66', '', '2'],                      ['ffffcc', '', '5'] ],
  [                                                                            ['cc9900', 'dark'],      ['ffcc00'],          ['ffcc33'] ],
  [                          ['666600', 'dark'],      ['999900', 'dark'],      ['cccc00', 'dark'],      ['ffff00', 'prime'], ['ffff33'],          ['ffff66'],          ['ffff99'] ],
  [                          ['336600', 'dark', '4'], ['669900', 'dark', '2'], ['99cc00', 'dark'],      ['ccff00'],          ['ccff33'],          ['ccff66', '', '2'], ['ccff99', '', '4'] ],
  [                                                                            ['66cc00', 'dark', '2'], ['99ff00'],          ['99ff33', '', '2'] ],
  [ ['003300', 'dark', '5'],                          ['339900', 'dark', '2'],                          ['66ff00'],                               ['99ff66', '', '2'],                     ['ccffcc', '', '5'] ],
  [                                                                            ['33cc00', 'dark'],      ['33ff00'],          ['66ff33'] ],
  [                          ['006600', 'dark'],      ['009900', 'dark'],      ['00cc00', 'dark'],      ['00ff00', 'prime'], ['33ff33'],          ['66ff66'],          ['99ff99'] ],
  [                          ['006633', 'dark', '4'], ['009933', 'dark', '2'], ['00cc33', 'dark'],      ['00ff33'],          ['33ff66'],          ['66ff99', '', '2'], ['99ffcc', '', '4'] ],
  [                                                                            ['00cc66', 'dark', '2'], ['00ff66'],          ['33ff99', '', '2'] ],
  [ ['003333', 'dark', '5'],                          ['009966', 'dark', '2'],                          ['00ff99'],                               ['66ffcc', '', '2'],                     ['ccffff', '', '5'] ],
  [                                                                            ['00cc99', 'dark'],      ['00ffcc'],          ['33ffcc'] ],
  [                          ['006666', 'dark'],      ['009999', 'dark'],      ['00cccc', 'dark'],      ['00ffff', 'prime'], ['33ffff'],          ['66ffff'],          ['99ffff'] ],
  [                          ['003366', 'dark', '4'], ['006699', 'dark', '2'], ['0099cc', 'dark'],      ['00ccff'],          ['33ccff'],          ['66ccff', '', '2'], ['99ccff', '', '4'] ],
  [                                                                            ['0066cc', 'dark', '2'], ['0099ff'],          ['3399ff', '', '2'] ],
  [ ['000033', 'dark', '5'],                          ['003399', 'dark', '2'],                          ['0066ff'],                               ['6699ff', '', '2'],                     ['ccccff', '', '5'] ],
  [                                                                            ['0033cc', 'dark'],      ['0033ff'],          ['3366ff'] ],
  [                          ['000066', 'dark'],      ['000099', 'dark'],      ['0000cc', 'dark'],      ['0000ff', 'prime'], ['3333ff'],          ['6666ff'],          ['9999ff']],
  [                          ['330066', 'dark', '4'], ['330099', 'dark', '2'], ['0033cc', 'dark'],      ['3300ff'],          ['6633ff'],          ['9966ff', '', '2'], ['cc99ff', '', '4'] ],
  [                                                                            ['6600cc', 'dark', '2'], ['6600ff'],          ['9933ff', '', '2'] ],
  [ ['330033', 'dark', '5'],                          ['660099', 'dark', '2'],                          ['9900ff'],                               ['cc66ff', '', '2'],                     ['ffccff', '', '5'] ],
  [                                                                            ['9900cc', 'dark'],      ['cc00ff'],          ['cc33ff'] ],
  [                          ['660066', 'dark'],      ['990099', 'dark'],      ['cc00cc', 'dark'],      ['ff00ff', 'prime'], ['ff33ff'],          ['ff66ff'],          ['ff99ff'] ],
  [                          ['660033', 'dark', '2'], ['990066', 'dark', '2'], ['cc0099', 'dark'],      ['ff00cc'],          ['ff33cc'],          ['ff66cc', '', '2'], ['ff99cc', '', '2'] ],
  [                                                                            ['cc0066', 'dark'],      ['ff0099'],          ['ff3399'] ],

  [ ['&nbsp;', '', '21' ], ['Secondary Color Table', '', '', '5'], ['&nbsp', '', '21'], ['Other<br>colors'], ['&nbsp', '', '21'] ],

  [ ['663333', 'dark', '3'], ['993366', 'dark'],      ['cc3366'], ['cc6699'],          ['cc9999', '', '3'], ['996666', 'dark'] ],
  [                          ['993333', 'dark'],      ['cc3333'], ['cc6666'],                               ['999966', 'dark'] ],
  [                          ['996633', 'dark', '2'], ['cc6633'], ['cc9966', '', '2'],                      ['669966', 'dark'] ],
  [ ['666633', 'dark', '3'],                          ['cc9933'],                      ['cccc99', '', '3'], ['669999', 'dark'] ],
  [                          ['999933', 'dark'],      ['cccc33'], ['cccc66'],                               ['666699', 'dark'] ],
  [                          ['669933', 'dark', '2'], ['99cc33'], ['99cc66', '', '2'],                      ['996699', 'dark'] ],
  [ ['336633', 'dark', '3'],                          ['66cc33'],                      ['99cc99', '', '3'], ['&nbsp', '', '16'] ],
  [                          ['339933', 'dark'],      ['33cc33'], ['66cc66'] ],
  [                          ['339966', 'dark', '2'], ['33cc66'], ['66cc99', '', '2'] ],
  [ ['336666', 'dark', '3'],                          ['33cc99'],                      ['99cccc', '', '3'] ],
  [                          ['339999', 'dark'],      ['33cccc'], ['66cccc'] ],
  [                          ['336699', 'dark', '2'], ['3399cc'], ['6699cc', '', '2'] ],
  [ ['333366', 'dark', '3'],                          ['3366cc'],                      ['9999cc', '', '3'] ],
  [                          ['333399', 'dark'],      ['3333cc'], ['6666cc'] ],
  [                          ['663399', 'dark', '2'], ['6633cc'], ['9966cc', '', '2'] ],
  [ ['663366', 'dark', '3'],                          ['9933cc'],                      ['cc99cc', '', '3'] ],
  [                          ['993399', 'dark'],      ['cc33cc'], ['cc66cc'] ],
  [                          ['993366', 'dark'],      ['cc3399'], ['cc6699'] ],
];

my $doc_magic = { 'colors' => sub { table( 2, { 'class' => 'color', 'style' => 'width:99%', 'rows' => [['data', $rows]]} ) } };
#print Dumper(\@rows);
page( 'code' => sub { story(*DATA, { 'doc magic' => $doc_magic }) });

__DATA__
I use this B<color chart> when I am trying to decide on a color scheme for a new project.
& colors