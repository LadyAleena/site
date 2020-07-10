#!perl
#
# run all tests at once with:
# cd files
# prove -lv t/fancy/
#
# or with perl:
# perl -Ilib t/fancy/100-fancy-map-functions.t

use strict;
use warnings;

# Start with the most common Testing module
# ... it provides ok(), use_ok(), cmp_ok(), is_deeply() and others
# ... we finish wwith done_testing()

use Test::More;

# Test that Fancy::Map can be use'd exporting fancy_map
# ... and die if it can't
BEGIN {
    use_ok( 'Fancy::Map', 'fancy_map' )
      or die "# Fancy::Map not available\n";
}

my @input = (
    { 'before' => 'glass', 'after' => 'beads' },
    [
        map( "sparkley $_",
            ( 'red', 'yellow', 'green', 'cyan', 'blue', 'magenta' ) ),
        'white', 'black', 'gray'
    ]
);

my $output = [
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

# is_deeply() compares complex data structures
# In this case we compare the output of fancy_map()
# ... with the desired $output
is_deeply( [ fancy_map(@input) ], $output, 'fancy_map works ok for pod example' );

# When testing, extremes should be checked as well
is_deeply( [fancy_map()],[], 'fancy_map returns nothing when given nothing' );

# How 'before' and 'after' are handled (especially when absent) should also be tested
# ... TODO

done_testing();
