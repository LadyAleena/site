#!/usr/bin/perl
# This is the index for Miscellany.
use strict;
use warnings FATAL => qw( all );

use CGI::Carp qw(fatalsToBrowser);
use CGI::Simple;
use HTML::Entities qw(encode_entities);
use Lingua::EN::Inflect qw(A NUMWORDS);

use lib '../files/lib';
use Page::Base     qw(page);
use Page::Menu     qw(file_menu);
use Page::Story    qw(story);
use HTML::Elements qw(list span anchor object figure);
use Util::Data     qw(file_directory file_list make_hash);
use Util::Convert  qw(searchify);
use Page::Line     qw(line);
use Fancy::Join::Defined       qw(join_defined);
use Random::Body::Modification qw(random_body_modification);
use Random::Color              qw(random_color);
use Random::Descriptor         qw(random_descriptor);
use Random::Misc               qw(random_sexual_orientation random_relationship);

my $cgi        = CGI::Simple->new;
my $page       = $cgi->param('page') ? encode_entities($cgi->param('page'),'/<>"') : undef;
my $pages_dir  = file_directory('Miscellany', 'text');
my @pages_list = file_list($pages_dir, { 'type' => 'f', 'uppercase' => 1, 'sort' => 'article' });
my @pages      = map { s/\.txt//; s/_/ /g; $_ } @pages_list;
my $heading    = q(Lady Aleena's miscellany);
my $page_file  = "$pages_dir/index.txt";
if ( $page && grep { $_ eq $page } @pages ) {
  $heading     = $page;
  $page_file   = "$pages_dir/$page.txt";
  $page_file   =~ s/ /_/g;
}
open(my $page_fh, '<', $page_file) || die "Can't open $page_file. $!";

# Start Jokes 1
my @jokes = <<List_end =~ m/(.+\n)/g;
Creation of Pussy
Does the Damn Thing work?
M R DUCKS
The New Priest
Now I'm old and feeble, and my pilot light is out
The purpose of the cluss in furmpaling is to remove
Pussy is a funny creature
Revised Retirement Policy
Seminars For Men
The Shit List
So, you don't know Jack Schitt?
List_end

# End Jokes 1
# Start Random orgy 1
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

my $participants = (3..10)[rand 8];
my @participants;
push @participants, participant for (3..$participants);
# End Random orgy 1

my $magic;
$magic->{'pages'}  = sub {
  my $file_menu = file_menu('page', \@pages, $page);
  list(4, 'u', $file_menu);
};
$magic->{'hidden'} = qq(class="hidden");
# Start BBSs
$magic->{'bbss'}   = sub {
  my $BBSs = make_hash( 'file' => ['Miscellany', 'bbs_list.txt'], 'headings' => [qw(name domain ip site)] );

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
# Start Genres
$magic->{'genres'} = sub {
  figure(6, sub {
    my $link = '../../files/images/Miscellany/Genre.svg';
    line(7, object( '', { 'data' => $link, 'type' => 'image/svg+xml'})); # object used instead of img, b/c img won't render svg properly
  }, { 'class' => 'svg_group'  });
};
# End Genres
# Start Jokes 2
$magic->{'jokes'}  = sub {
  my @funnies = map {
    chomp $_;
    anchor($_, {
      'href' => "http://www.google.com/search?safe=off&amp;q=joke+".searchify($_),
      'target' => 'ex_tab' }
    );
  } @jokes;
  list(3,'u',\@funnies);
};
# End Jokes 2
# Start Random orgy 2
$magic->{'participants'} = join("\n", @participants)."\n";
# End Random orgy 2

page(
  'heading' => $heading,
  'selected' => $page,
  'code' => sub {
    story($page_fh, { 'doc magic' => $magic, 'line magic' => $magic });
  }
);
