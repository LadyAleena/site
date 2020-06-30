package Random::RPG::World::WorldBuildersGuidebook::Race;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT = qw(random_race);
our @EXPORT_OK = qw(random_dominant_race random_major_race random_minor_race random_racial_makeup);

use Random::SpecialDice qw(percentile);

use Random::RPG::World::WorldBuildersGuidebook::RacePosition qw(random_race_position);

# From the World Builder's Guidebook by Richard Baker (c) TSR
# Dominant Races (Table 19)

my %races;

# Land races
# Dominant races

$races{land}{dominant}{$_} = 'dragon'     for 1..3;
$races{land}{dominant}{$_} = 'dwarf'      for 4..16;
$races{land}{dominant}{$_} = 'elf'        for 17..22;
$races{land}{dominant}{$_} = 'sylvan elf' for 23..25;
$races{land}{dominant}{$_} = 'giant'      for 26..31;
$races{land}{dominant}{$_} = 'gnoll'      for 32..36;
$races{land}{dominant}{$_} = 'goblin'     for 37..46;
$races{land}{dominant}{$_} = 'hobgoblin'  for 47..49;
$races{land}{dominant}{$_} = 'human'      for 50..78;
$races{land}{dominant}{$_} = 'kobold'     for 79..81;
$races{land}{dominant}{$_} = 'ogre'       for 82..86;
$races{land}{dominant}{$_} = 'orc'        for 87..95;
$races{land}{dominant}{96} = 'orog';
$races{land}{dominant}{$_} = 'thri-kreen' for 97..100;

# Major races

$races{land}{major}{$_} = 'aarakocra'   for 1..2;
$races{land}{major}{3}  = 'beholder-kin';
$races{land}{major}{4}  = 'broken one';
$races{land}{major}{5}  = 'bullywug';
$races{land}{major}{$_} = 'centaur'     for 6..8;
$races{land}{major}{9}  = 'dragon';
$races{land}{major}{$_} = 'dwarf'       for 10..16;
$races{land}{major}{$_} = 'elf'         for 17..20;
$races{land}{major}{$_} = 'sylvan elf'  for 21..23;
$races{land}{major}{24} = 'gargoyle';
$races{land}{major}{$_} = 'giant'       for 25..28;
$races{land}{major}{29} = 'gibberling';
$races{land}{major}{30} = 'giff';
$races{land}{major}{31} = 'gith';
$races{land}{major}{$_} = 'gnoll'       for 32..33;
$races{land}{major}{$_} = 'gnome'       for 34..35;
$races{land}{major}{36} = 'tinker gnome';
$races{land}{major}{$_} = 'goblin'      for 37..42;
$races{land}{major}{43} = 'grell';
$races{land}{major}{44} = 'grimlock';
$races{land}{major}{$_} = 'halfling'    for 45..47;
$races{land}{major}{48} = 'harpy';
$races{land}{major}{$_} = 'hobgoblin'   for 49..50;
$races{land}{major}{$_} = 'human'       for 51..65;
$races{land}{major}{$_} = 'kobold'      for 66..68;
$races{land}{major}{69} = 'urd kobold';
$races{land}{major}{$_} = 'lizard man'  for 70..72;
$races{land}{major}{73} = 'taer mammal';
$races{land}{major}{74} = 'manscorpion';
$races{land}{major}{$_} = 'minotaur'    for 75..76;
$races{land}{major}{77} = 'mold man';
$races{land}{major}{78} = 'mongrolman';
$races{land}{major}{79} = 'neogi';
$races{land}{major}{$_} = 'ogre'        for 80..82;
$races{land}{major}{$_} = 'orc'         for 83..88;
$races{land}{major}{89} = 'orog';
$races{land}{major}{90} = 'rakshasa';
$races{land}{major}{$_} = 'sylvan folk' for 91..92;
$races{land}{major}{93} = 'tabaxi';
$races{land}{major}{94} = 'tasloi';
$races{land}{major}{$_} = 'thri-kreen'  for 95..96;
$races{land}{major}{97} = 'troll';
$races{land}{major}{98} = 'wemic';
$races{land}{major}{$_} = 'yuan-ti'     for 99..100;

# Minor races

$races{land}{minor}{$_} = 'aarakocra'   for 1..2;
$races{land}{minor}{3}  = 'arcane';
$races{land}{minor}{4}  = 'beholder-kin';
$races{land}{minor}{5}  = 'broken one';
$races{land}{minor}{6}  = 'bullywug';
$races{land}{minor}{$_} = 'centaur'     for 7..8;
$races{land}{minor}{9}  = 'doppleganger';
$races{land}{minor}{10} = 'dragon';
$races{land}{minor}{$_} = 'dwarf'       for 11..14;
$races{land}{minor}{$_} = 'elf'         for 15..16;
$races{land}{minor}{$_} = 'sylvan elf'  for 17..18;
$races{land}{minor}{19} = 'gargoyle';
$races{land}{minor}{20} = 'jann genie';
$races{land}{minor}{$_} = 'giant'       for 21..23;
$races{land}{minor}{24} = 'gibberling';
$races{land}{minor}{25} = 'giff';
$races{land}{minor}{26} = 'gith';
$races{land}{minor}{27} = 'gnoll';
$races{land}{minor}{$_} = 'gnome'       for 28..29;
$races{land}{minor}{30} = 'tinker gnome';
$races{land}{minor}{31} = 'spriggan gnome';
$races{land}{minor}{$_} = 'goblin'      for 32..36;
$races{land}{minor}{37} = 'grell';
$races{land}{minor}{38} = 'grimlock';
$races{land}{minor}{39} = 'grippli';
$races{land}{minor}{$_} = 'halfling'    for 40..41;
$races{land}{minor}{42} = 'harpy';
$races{land}{minor}{43} = 'hobgoblin';
$races{land}{minor}{$_} = 'human'       for 44..61;
$races{land}{minor}{62} = 'kenku';
$races{land}{minor}{$_} = 'kobold'      for 63..64;
$races{land}{minor}{65} = 'urd kobold';
$races{land}{minor}{$_} = 'lizard man'  for 66..68;
$races{land}{minor}{69} = 'hsing-sing mammal';
$races{land}{minor}{70} = 'taer mammal';
$races{land}{minor}{71} = 'manscorpion';
$races{land}{minor}{$_} = 'minotaur'    for 72..73;
$races{land}{minor}{74} = 'mold man';
$races{land}{minor}{75} = 'mongrelman';
$races{land}{minor}{76} = 'neogi';
$races{land}{minor}{$_} = 'ogre'        for 77..78;
$races{land}{minor}{79} = 'ogre mage';
$races{land}{minor}{$_} = 'orc'         for 80..86;
$races{land}{minor}{87} = 'orog';
$races{land}{minor}{88} = 'rakshasa';
$races{land}{minor}{89} = 'sylvan folk';
$races{land}{minor}{90} = 'tabaxi';
$races{land}{minor}{91} = 'tasloi';
$races{land}{minor}{$_} = 'thri-kreen' for 92..95;
$races{land}{minor}{96} = 'troll';
$races{land}{minor}{97} = 'wemic';
$races{land}{minor}{98} = 'yeti';
$races{land}{minor}{$_} = 'yuan-ti'    for 99..100;

# Subterranean races
# Dominant races

$races{subterranean}{dominant}{$_} = 'aboleth'       for 1..19;
$races{subterranean}{dominant}{$_} = 'bugbear'       for 20..29;
$races{subterranean}{dominant}{$_} = 'derro dwarf'   for 30..38;
$races{subterranean}{dominant}{$_} = 'duergar dwarf' for 39..53;
$races{subterranean}{dominant}{$_} = 'drow elf'      for 54..68;
$races{subterranean}{dominant}{$_} = 'mind flayer'   for 69..88;
$races{subterranean}{dominant}{$_} = 'troglodyte'    for 89..100;

# Major races

$races{subterranean}{major}{$_} = 'aboleth'           for 1..12;
$races{subterranean}{major}{$_} = 'bugbear'           for 13..18;
$races{subterranean}{major}{$_} = 'derro dwarf'       for 19..24;
$races{subterranean}{major}{$_} = 'duergar dwarf'     for 25..38;
$races{subterranean}{major}{$_} = 'drow elf'          for 39..51;
$races{subterranean}{major}{$_} = 'gibberling'        for 52..56;
$races{subterranean}{major}{$_} = 'jermlaine gremlin' for 57..62;
$races{subterranean}{major}{$_} = 'grimlock'          for 63..68;
$races{subterranean}{major}{$_} = 'hook horror'       for 69..75;
$races{subterranean}{major}{$_} = 'kuo-toa'           for 76..82;
$races{subterranean}{major}{$_} = 'mind flayer'       for 83..93;
$races{subterranean}{major}{$_} = 'quaggoth'          for 94..95;
$races{subterranean}{major}{$_} = 'troglodyte'        for 90..100;

# Minor races

$races{subterranean}{minor}{$_} = 'abolth'             for 1..9;
$races{subterranean}{minor}{$_} = 'bugbear'            for 10..14;
$races{subterranean}{minor}{$_} = 'cloaker'            for 15..17;
$races{subterranean}{minor}{$_} = 'derro dwarf'        for 18..22;
$races{subterranean}{minor}{$_} = 'duerger dwarf'      for 23..33;
$races{subterranean}{minor}{$_} = 'drow elf'           for 34..42;
$races{subterranean}{minor}{$_} = 'gibberling'         for 43..47;
$races{subterranean}{minor}{$_} = 'svirfneblin gnome'  for 48..57;
$races{subterranean}{minor}{$_} = 'jermlaine gremline' for 58..61;
$races{subterranean}{minor}{$_} = 'grimlock'           for 62..66;
$races{subterranean}{minor}{$_} = 'hook horror'        for 67..72;
$races{subterranean}{minor}{$_} = 'kuo-toa'            for 73..80;
$races{subterranean}{minor}{$_} = 'manscorpion'        for 81..83;
$races{subterranean}{minor}{$_} = 'mind flayer'        for 84..92;
$races{subterranean}{minor}{$_} = 'myconid'            for 93..95;
$races{subterranean}{minor}{96} = 'quaggoth';
$races{subterranean}{minor}{$_} = 'troglodyte'         for 97..100;

# Marine races
# Dominant races

$races{marine}{dominant}{$_} = 'ixitxachitl' for 1..18;
$races{marine}{dominant}{$_} = 'locathah'    for 19..31;
$races{marine}{dominant}{$_} = 'merman'      for 32..54;
$races{marine}{dominant}{$_} = 'sahuagin'    for 55..89;
$races{marine}{dominant}{$_} = 'triton'      for 90..100;

# Major races

$races{marine}{major}{$_} = 'crabman'     for 1..4;
$races{marine}{major}{$_} = 'aquatic elf' for 5..16;
$races{marine}{major}{$_} = 'giant'       for 17..24;
$races{marine}{major}{$_} = 'ixitxachitl' for 25..41;
$races{marine}{major}{$_} = 'locathah'    for 42..49;
$races{marine}{major}{$_} = 'merman'      for 50..66;
$races{marine}{major}{$_} = 'merrow ogre' for 67..71;
$races{marine}{major}{$_} = 'sahuagin'    for 72..90;
$races{marine}{major}{$_} = 'tako'        for 91..94;
$races{marine}{major}{$_} = 'triton'      for 95..99;
$races{marine}{major}{100} = 'scrag troll';

# Minor races

$races{marine}{minor}{$_} = 'crabman'             for 1..2;
$races{marine}{minor}{$_} = 'dragon'              for 3..4;
$races{marine}{minor}{$_} = 'dolphin'             for 5..9;
$races{marine}{minor}{$_} = 'aquatic elf'         for 10..17;
$races{marine}{minor}{$_} = 'kapoacinth gargoyle' for 18..19;
$races{marine}{minor}{$_} = 'giant'               for 20..23;
$races{marine}{minor}{$_} = 'koalinth hobgoblin'  for 24..27;
$races{marine}{minor}{$_} = 'ixitxachitl'         for 28..37;
$races{marine}{minor}{$_} = 'kraken'              for 38..42;
$races{marine}{minor}{$_} = 'locathah'            for 43..48;
$races{marine}{minor}{$_} = 'merman'              for 49..62;
$races{marine}{minor}{$_} = 'merrow ogre'         for 63..69;
$races{marine}{minor}{$_} = 'sahuagin'            for 70..89;
$races{marine}{minor}{$_} = 'tako'                for 90..93;
$races{marine}{minor}{$_} = 'triton'              for 94..99;
$races{marine}{minor}{100} = 'scrag troll';

sub random_race {
  my ($location,$prominence) = @_;
  warn "You did not specify if you wanted the 'dominant', 'major', or 'minor' race." if !$prominence;
  
  my $percent = percentile;
  return $races{$location}{$prominence}{$percent};
}

sub random_dominant_race {
  my $location = shift;
  return random_race($location,'dominant');
}

sub random_major_race {
  my $location = shift;
  return random_race($location,'major');
}

sub random_minor_race {
  my $location = shift;
  return random_race($location,'minor');
}

sub random_racial_makeup {
  my %races;
  for my $location ('land','subterranean','marine') {
    $races{$location}{dominant} = random_dominant_race($location);
    $races{$location}{major}    = random_major_race($location);
    $races{$location}{minor}    = random_minor_race($location);
    $races{$location}{'race postion'} = random_race_position;
  }

  return \%races;
}

1;