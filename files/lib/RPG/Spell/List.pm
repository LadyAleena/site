package RPG::Spell::List;
use strict;
use warnings FATAL => qw(all);
use Exporter qw(import);
our @EXPORT_OK = qw(spell_data);

use CGI::Carp qw(fatalsToBrowser);

use Util::Convert qw(filify);
use Util::Data qw(data_file make_hash);

my @headings = (qw(name school level range duration), 'area of effect', 'components', 'casting time', 'saving throw', 'description');
my $spells = make_hash( 'file' => ['Role_playing','spell_list.txt'], 'headings' => \@headings );

sub spell_description_from_file {
  my $spell_file = shift;
  open(my $spell_fh, '<:encoding(utf-8)', $spell_file) || die "Can't open $spell_file. $!";
  my $spell_description = do { local $/; readline($spell_fh) };
  return $spell_description;
}

sub spell_data {
  my ($spell) = @_;

  my @items;
  for my $stat (grep($_ !~ /(?:name|description)/, @headings)) {
    next if !$spells->{$spell}{$stat};
    my $stat_text = ucfirst $stat;
    push @items, qq(<strong>$stat_text:</strong> $spells->{$spell}{$stat});
  }

  my $spell_file = filify($spell);
  my @spell_description = $spells->{$spell}{'description'} ?
                          split(/\//, $spells->{$spell}{'description'}) :
                          spell_description_from_file(data_file('Role_playing/spell_descriptions',"$spell_file.txt"));

  my $spell_out = { 'heading' => $spells->{$spell}{'name'}, 'stats' => [\@items, { class => 'spell_stats' }], 'description' => \@spell_description };
  return $spell_out;
}

1;