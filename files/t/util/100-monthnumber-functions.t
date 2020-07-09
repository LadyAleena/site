#!perl
#
# run all tests at once with:
# cd files
# prove -lv t/util/
#
# or with perl:
# perl -Ilib t/util/100-monthnumber-functions.t

use strict;
use warnings;

# Start with the most common Testing module
# ... it provides ok(), use_ok(), cmp_ok(), is_deeply(), diag() and others
# ... we finish with done_testing()

use Test::More;

# Test that Util::MonthNumber can be use'd exporting fancy_map
# ... and die if it can't
BEGIN {
    use_ok( 'Util::MonthNumber', 'month_number' )
      or die "# Util::MonthNumber not available\n";
}

# Select various data that tests all of whats expected
my %data = (
    'January' => 1,
    'Februar' => 2,
    'abril'   => 4,
);

for my $input (sort keys %data) {
    my $output = $data{$input};

    # diag() is how diagnostic data is properly sent to Test::More
    # ... Test::More can output to various formal testing data formats
    # ... in XML and what not, as well as in the default TAP format
    # ... you see on the screen. Avoid print or warn when doing tests
    diag 'Going to test ' . $input;

    # cmp_ok() allows us to test variables and gives us detailed diagnostics
    # ... note that the comparison operator is quoted text so that cmp_ok can
    # ... perform diagnostics. Otherwise it would just get a true / false input
    cmp_ok(month_number($input), 'eq', $output,
        'Checking result of month_number ' . $input);

}

# Testing should also include unknown input parameters as well as undef (empty) input parameters
# ... TODO

done_testing();
