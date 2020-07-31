package Random::RPG::MagicItem;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(PL_N);

use Fancy::Rand   qw(fancy_rand tiny_rand);
use Random::Range qw(random_radius);
use Random::SpecialDice qw(percentile permille);

our $VERSION   = '1.000';
our @EXPORT_OK = qw(random_magic_item random_magic_item_action magic_item_enhancement magic_item_quirk);

my %magic_items = (
  'liquids' => [qw(elixer oil perfume philter pigment potion salve water)],
  'scrolls' => [qw(paper parchment scroll)],
  'rings'   => ['ring'],
  'rods'    => ['rod'],
  'staves'  => [qw(cane gaff staff)],
  'wands'   => ['wand'],
  'books'   => [qw(book libram manual map spellbook tome)],
  'gems and jewelry' => [qw(amulet ankh badge bracelet brooche cameo charm crown crystal earring eyeglasses gem glass goggles icon leave lense locket medallion monocle necklace pearl pendant periapt phyactery prism scarab scepter scope talisman torc), 'holy symbol'],
  'clothing'    => [qw(cape cloak cloth coat dress fur gown robe shirt stocking tunic vest vestment)],
  'accessories' => [qw(anklet armband band boot bracer claw collar gauntlet glove hand pegleg shoe slipper sock)],
  'girdles and helms'   => [qw(belt buckle cap circlet girdle hat headband helmet mask sash turban)],
  'containers'          => [qw(bag barrel basin beaker bottle bowl box brazier cabinet cage can canister canteen case cask cauldron censer chalice chest coffin container decanter flagon flask goblet horn jar jug kettle mug pitcher prison scabbard tub urn)],
  'dust and stones'     => [qw(apple bead berry bone candle cheese dust egg feather finger incense marble pie powder rock rose seed smoke soap stone tart tooth wax weed), 'air spore', 'ioun stone'],
  'household items'     => [qw(anvil apron art awl banner bellow bench blanket broom brush button carpet chair cord cot curtain desk door fan fork gavel hammock handkerchief harness hasp hinge hourglass inkwell iron key map ladder ladle lamp lock log match mirror muzzle nail needle pan pen pick pill plate poker rake razor rope saw seal shaker shovel spoon stair string sundial table tapestry tea telescope tent thread throne torch utensil vane yoke), 'balance scale', 'candle snuffer', 'fishing pole', 'grappling iron', 'mortar and pestle', 'quill pen', 'smoking pipe', 'spinning wheel', 'tool set'],
  'musical instruments' => [map( "$_ instrument", qw(percussion stringed wind brass) )],
  'weird stuff'         => [qw(anchor arm astrolabe ball balloon beacon boat bridle cast castle chain chariot coin cube device dice disk figurehead figurine fire fountain globe horseshoe hut idol kite locator mast mobile nest oar oracle orb pedestal pool rudder saddle sail ship skull sledge sphere statue transportation tree turret well wheel wing), 'chess game', 'crystal ball', 'deck of cards', 'spelljamming heml'],
  'humorous items'      => ['humorous item'],
  'armor and shields'   => [qw(armor barding bonnet caparison helmet shield)],
  'weapons'   => [qw(arrow axe ballista blowgun bow catapult club dagger dart flail hammer harpoon helmseeker javelin lance mace mattock net paddleboard pellet polearm quiver shot sickle sling spear sword whip), 'battering ram', 'explosive device', 'spelljamming ram', 'throwing star'],
  'artifacts' => ['artifact'],
);

my %reverse_magic_items;
for my $key (keys %magic_items) {
  $reverse_magic_items{$_} = $key for @{$magic_items{$key}};
}

my %magic_item_enhancement = (
  'liquids' =>  1,
  'scrolls' => 10,
  'rings'   =>  3,
  'rods'    => 15,
  'staves'  =>  7,
  'wands'   =>  8,
  'books'   =>  3,
  'gems and jewelry' => 1,
  'clothing'    => 6,
  'accessories' => 5,
  'girdles and helms'   =>  5,
  'containers'          =>  3,
  'dust and stones'     =>  2,
  'household items'     =>  1,
  'musical instruments' =>  4,
  'weird stuff'         =>  2,
  'humorous items'      => 20,
  'armor and shields'   =>  6,
  'weapons'             =>  1,
);

my %magic_item_quirk = (
  'armor'    => { 'low' => 407, 'high' => 412 },
  'elixers'  => { 'low' =>  35, 'high' =>  36 },
  'philters' => { 'low' => 442, 'high' => 443 },
  'powders'  => { 'low' => 765, 'high' => 767 },
  'potions'  => { 'low' => 843, 'high' => 844 },
  'rings'    => { 'low' => 739, 'high' => 741 },
  'rods'     => { 'low' => 728, 'high' => 742 },
  'scrolls'  => { 'low' => 731, 'high' => 740 },
  'shields'  => { 'low' => 922, 'high' => 927 },
  'staves'   => { 'low' => 698, 'high' => 704 },
  'weapons'  => { 'low' =>   2, 'high' =>   2 },
  'enhancement' => { 'low' => 71, 'high' => 80 },
);

my %quirks_roll;
$quirks_roll{$_} = 0 for  (1..86);
$quirks_roll{$_} = 1 for (87..94);
$quirks_roll{$_} = 2 for (95..98);
$quirks_roll{$_} = 3 for (99..100);

sub random_magic_item {
  my ($user_magic_item, $user_additions) = @_;
  my $magic_item = fancy_rand(\%magic_items, $user_magic_item, { caller => 'random_magic_item', additions => $user_additions ? $user_additions : undef });
  return $magic_item;
}

sub magic_item_enhancement {
  my ($magic_item) = @_;
  my $group = $reverse_magic_items{$magic_item};
  return $group && permille() <= $magic_item_enhancement{$group} ? 1 : 0;
}

sub magic_item_quirk {
  my ($magic_item) = @_;
  $magic_item = $reverse_magic_items{$magic_item} && $reverse_magic_items{$magic_item} eq 'weapons' ? 'weapons' : $magic_item;

  my $quirked = 0;
  if ($magic_item_quirk{$magic_item}) {
    my $quirk_rolls = $magic_item_quirk{$magic_item};
    my $roll = $magic_item eq 'enhancement' ? percentile() : permille();

    if ($magic_item eq 'weapons') {
      my $next_roll = $roll >= $quirk_rolls->{low} && $roll <= $quirk_rolls->{high} ? percentile() : 0;
      $quirked = $next_roll == 64 ? 1 : 0;
    }
    else {
      $quirked = $roll >= $quirk_rolls->{low} && $roll <= $quirk_rolls->{high} ? 1 : 0;
    }
  }

  my $quirks = $quirked ? $quirks_roll{percentile()} : 0;

  return $quirks;
}

sub magic_item_verb {
  my ($magic_item) = @_;
  my @verbs = ('causes '.tiny_rand(qw(dys mal)).'functions in', qw(attracts drains destroys interupts recharges repels enhances));
  my $base_verb = tiny_rand(@verbs);
  my $verb = $base_verb eq 'enhances' ? magic_item_enhancement($magic_item) ? 'enhances' : magic_item_verb($magic_item) : $base_verb;
  return $verb;
}

sub random_magic_item_action {
  my $magic_item = random_magic_item('all', ['items']);
  my $verb = magic_item_verb($magic_item);

  my $magic_item_action = tiny_rand(
    join(' ', ('can', tiny_rand('use all', 'not use any'), 'magical', PL_N($magic_item))),
    join(' ', ($verb, 'magical', PL_N($magic_item), random_radius('touch','imperial')))
  );

  return $magic_item_action;
}

=pod

=encoding utf8

=head1 NAME

B<Random::RPG::MagicItem> selects random magic items from I<Advanced Dungeons & Dragons>, Second Edition.

=head1 VERSION

This document describes Random::RPG::MagicItem version 1.000.

=head1 SYNOPSIS

  use Random::RPG::MagicItem qw(random_magic_item random_magic_item_action);

=head1 DEPENDENCIES

Random::RPG::MagicItem depends on L<Fancy::Rand>, L<Random::Range>, L<Random::SpecialDice>, L<Lingua::EN::Inflect>, and L<Exporter>.

=head1 AUTHOR

Lady Aleena

=cut

1;