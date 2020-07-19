package Random::Food;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(random_food random_drink);

use Fancy::Rand qw(fancy_rand);
use Fancy::Map qw(fancy_map);
use Fancy::Open qw(fancy_open);
use Util::Data qw(file_directory);

my $directory = file_directory('Random/Food', 'data');
my @Klondike_flavors = fancy_open("$directory/Klondike_flavors.txt", { 'after' => " Klondike bar" });
my @Kool_Aid_flavors = fancy_open("$directory/Kool-Aid_flavors.txt", { 'after' => " Kool-Aid" });
my @MandMs_flavors   = fancy_open("$directory/MandMs_flavors.txt",   { 'after' => " M&M" });

my %foods = (
  'fruit' => [qw(apple apricot banana blueberry cherry cranberry grape grapefruit lemon lime orange peach pear plum raspberry strawberry tomato)],
  'tuber' => ['potato','sweet potato','yam'],
  'meat'  => [qw(beef lamb chicken pork turkey fish)],
  'junk food'   => [ map( "$_ chips", qw(corn potato) ), 'pretzels', 'crackers'],
  'Lucky Charm' => [ fancy_map({ 'after'=> 'lucky charm' }, [
    'heart','star','horseshoe','green clover','blue moon','hourglass','rainbow','red balloon',
    map( "swirled $_ moon", qw(pink orange yellow green blue purple) ),
    map( "$_->[0] hat with a $_->[1] clover", (['green', 'dark green'], ['blue', 'pink'], ['purple', 'green'], ['dark green', 'orange'], ['yellow', 'blue'], ['orange', 'green']) ),
    map( "$_->[0] and $_->[1] swirled diamond", (['dark green', 'yellow'], ['purple', 'pink'], ['blue', 'green'], ['pink', 'white'], ['green', 'orange']) )
  ])],
  'Klondike bar' => [@Klondike_flavors],
  'M&M'          => [@MandMs_flavors],
);

my %drinks = (
  'beer'      => ['pale ale', map( "$_ beer", qw(stout mild wheat lager lambic) )],
  'hot drink' => [qw(coffee tea cider)],
  'juice'     => ['lemonade', map("$_ juice", qw(apple grape orange cranberry grapefruit tomato))],
  'Kool-Aid'  => [@Kool_Aid_flavors],
);

sub random_food {
  my ($user_food, $user_additions) = @_;
  my $food = fancy_rand(\%foods, $user_food, { caller => 'random_food', additions => $user_additions ? $user_additions : undef });
  return $food;
}

sub random_drink {
  my ($user_drink, $user_additions) = @_;
  my $drink = fancy_rand(\%drinks, $user_drink, { caller => 'random_drink', additions => $user_additions ? $user_additions : undef });
  return $drink;
}

=pod

=encoding utf8

=head1 NAME

B<Random::Food> selects either a random food or drink.

=head1 SYNOPSIS

  use Random::Food qw(random_food random_drink);

  my $food  = random_food('all');       # selects any food on the list
  my $fruit = random_food('fruit');     # selects a fruit
  my $tuber = random_food('tuber');     # selects a tuber
  my $meat  = random_food('meat');      # selects a meat
  my $junk  = random_food('junk food'); # selects a junk food

  my $Lucky_Charm  = random_food('Lucky Charm');  # selects a magically delicious Lucky Charm
  my $Klondike_bar = random_food('Klondike bar'); # selects a Klondike bar flavor
  my $MandM        = random_food('M&M');          # selects an M&M flavor

  print random_food('help'); # get random_food options

  my $drink = random_drink('all');       # selects any drink on the list
  my $beer  = random_drink('beer');      # selects a beer or ale
  my $hot   = random_drink('hot drink'); # selects a hot drink
  my $juice = random_drink('juice');     # selects a juice

  my $KoolAid = random_drink('Kool-Aid'); # selects a Kool-Aid flavor

  print random_drink('help'); # get random_drink options


=head1 DEPENDENCIES

Random::Food depends on L<Fancy::Rand>, L<Fancy::Map>, J<Fancy::Open>, L<Util::Data>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;