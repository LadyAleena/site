package Fancy::Function;
use strict;
use warnings;
use Exporter qw(import);

use Fancy::Map               qw(fancy_map);
use Fancy::Rand              qw(fancy_rand fancy_rand_from_array);
use Fancy::Splice            qw(fancy_splice);
use Fancy::Split             qw(fancy_split);
use Fancy::Join::Defined     qw(join_defined);
use Fancy::Join::Grammatical qw(grammatical_join);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(
  fancy_map
  fancy_rand
  fancy_rand_from_array
  fancy_splice
  fancy_split
  join_defined
  grammatical_join
);

=pod

=encoding utf8

=head1 NAME

B<Fancy::Function> is a collection of functions that have been given a bit of additional functionality.

=head1 SYNOPSIS

  use Fancy::Function qw(fancy_map fancy_splice fancy_split join_defined grammatical_join);

=head2 fancy_map

  my $colors = [fancy_map(
                 { 'before => 'glass', 'after' => 'beads' },
                 [map("sparkley $_", ('red', 'yellow', 'green', 'cyan', 'blue', 'magenta')), 'white', 'black', 'gray']
               )];

  [
    'glass sparkley red beads',
    'glass sparkley yellow beads',
    'glass sparkley green beads',
    'glass sparkley cyan beads',
    'glass sparkley blue beads',
    'glass sparkley magenta beads',
    'glass white beads',
    'glass black beads',
    'glass gray beads'
  ];

=head2 fancy_splice

  my @colors = ('red', 'orange', 'yellow', 'spring', 'green', 'teal', 'cyan', 'azure',
                'blue', 'violet', 'magenta', 'pink', 'white', 'black', 'gray');
  my $list = fancy_splice(2, @colors);

  [
    ['red','orange'],
    ['yellow','spring'],
    ['green','teal'],
    ['cyan','azure'],
    ['blue','violet'],
    ['magenta','pink'],
    ['white','black'],
    [gray']
  ];

=head2 fancy_split

  my $string = "red, orange, yellow, spring, green, teal, cyan, azure,
                blue, violet, magenta, pink, white, black, gray";
  my @array = fancy_split(', ', $string, 2);

  [
    'red, orange',
    'yellow, spring',
    'green, teal',
    'cyan, azure',
    'blue, violet',
    'magenta, pink',
    'white, black',
    'gray'
  ];

=head2 join_defined

  my @base_colors = ('red', undef, 'green', undef, 'blue', undef);
  my $colors = join_defined(',', @base_colors);
  # red, green, blue

=head2 grammtical_join

  my @color_array = ('red', 'yellow', 'green', 'cyan', 'blue', 'magenta');
  my $colors = grammatical_join('and', @color_array);
  # red, yellow, green, cyan, blue, and magenta

=head1 DESCRIPTION

=head2 fancy_map

C<fancy_map> can be exported and returns a list of mapped values from a list which already has a map in it. It takes three parameters. The first two are in a hash reference with the values to be mapped before and after the values of the list. The third is a reference to the list.

  my @array = fancy_map( { 'before' => $before_value, 'after' => $after_value }, $list_with_a_map_in_it );

You can use C<fancy_map> here or from L<Fancy::Map>.

=head2 fancy_splice

C<fancy_splice> can be exported and returns a referenced array of arrays spliced by a user specified amount. It takes two paraments: the size of the groups and the list. The size can be any integer, and the list is an array.

You can use C<fancy_splice> here or from L<Fancy::Splice>.

=head2 fancy_split

C<fancy_split> can be exported and returns a referenced array split by a user specified amount. It takes two paraments: the size of the groups and the string to be split. The size can be any integer.

You can use C<fancy_split> here or from L<Fancy::Split>.

=head2 join_defined

C<join_defined> can be exported and returns a string of only defined values from a list. It takes two parameters: the character which will join the list and a reference to the list.

You can use C<join_defined> here or from L<Fancy::Join> or L<Fancy::Join::Defined>.

=head2 grammatical_join

C<grammatical_join> can be exported and returns a string of joined array values with commas and a comma with a conjunction between the last two values. It takes two parameters: the conjunction and the array. If any values within the array already have commas, semicolons will be used in place of commas.

You can use C<grammatical_join> here or from L<Fancy::Join> or L<Fancy::Join::Grammatical>.

=head3 Note

L<Lingua::EN::Inflect> has C<WORDLIST> and L<Lingua::EN::Inflexion> has C<wordlist> which does a little more than C<grammatical_join>.

=head1 DEPENDENCIES

Fancy::Function depends on L<Exporter>, L<Fancy::Map>, L<Fancy::Rand>, L<Fancy::Spice>, L<Fancy::Split>, L<Fancy::Join::Defined>, and L<Fancy::Join::Grammatical>.

=head1 AUTHOR

Lady Aleena

=cut

1;