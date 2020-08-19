package Page::Story::Magic::Miscellany;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(misc_magic);

use Lingua::EN::Inflect qw(A NUMWORDS);

use Page::Data     qw(make_hash);
use Page::Line       qw(line);
use Page::List::File qw(file_directory);
use Fancy::Join::Defined       qw(join_defined);
use Fancy::Open qw(fancy_open);
use Random::Body::Modification qw(random_body_modification);
use Random::Color              qw(random_color);
use Random::Descriptor         qw(random_descriptor);
use Random::Misc               qw(random_sexual_orientation random_relationship);
use HTML::Elements qw(list span anchor object figure);
use Util::Convert  qw(searchify);

sub age {
  my @ages = (18..90);
  return $ages[rand @ages];
}

sub participant {
  my $relationship = random_relationship;
  my $age          = NUMWORDS(age);
  my $gender       = qw(man woman)[rand 2];
  my $orientation  = random_sexual_orientation;
  my $somatotype   = random_body_modification('somatotype');
  my $quality      = A(random_descriptor('quality'));
  my $hair_color   = random_color('hair');
  my $eye_color    = random_color('eye');

  return ucfirst A("$relationship $age year old $somatotype $gender with $hair_color hair and $eye_color eyes who is $orientation and $quality lover.");
}

sub misc_magic {
  my $magic;
  my $data_dir = file_directory('Miscellany');

  $magic->{'hidden'} = qq(class="hidden");

  # Start BBSs
  $magic->{'bbss'}   = sub {
    my $BBSs = make_hash( 'file' => "$data_dir/bbs_list.txt", 'headings' => [qw(name domain ip site)] );

    my @BBS_list;
    for my $BBS (sort { $a->{'name'} cmp $b->{'name'} } values %$BBSs) {
      my $name         = $BBS->{'name'};
      my $link         = $BBS->{'site'};
      my $BBS_head     = $link ? anchor($name, { 'href' => "http://$link" }) : $name;
      my @telnet_links = map { $BBS->{$_} ? anchor($BBS->{$_}, { 'href' => "telnet://$BBS->{$_}" }) : undef } ('domain', 'ip');
      my $links_text   = join_defined(', ', @telnet_links);
      my $links        = span("($links_text)", { class => 'links' });
      push @BBS_list, "$BBS_head $links";
    }

    list(4, 'u', \@BBS_list, { class => 'two' });
  };
  # End BBSs

  my @jokes = fancy_open("$data_dir/jokes.txt");
  $magic->{'jokes'}  = sub {
    my @funnies = map {
      anchor($_, { 'href' => "http://www.google.com/search?safe=off&amp;q=joke+".searchify($_), 'target' => 'ex_tab' });
    } @jokes;
    list(4,'u',\@funnies);
  };

  $magic->{'genres'} = sub {
    my $image_dir = file_directory('Miscellany', 'images');
    figure(6, sub {
      line(7, object( '', { 'data' => "$image_dir/Genre.svg", 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
    }, { 'class' => 'svg_group'  });
  };

  my $participants = (3..10)[rand 8];
  my @participants;
  push @participants, participant for (3..$participants);
  $magic->{'participants'} = join("\n", @participants)."\n";

  return $magic;
}