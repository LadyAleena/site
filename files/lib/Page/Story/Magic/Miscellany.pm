package Page::Story::Magic::Miscellany;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);

use Lingua::EN::Inflect qw(A NUMWORDS);

use Fancy::Join::Defined qw(join_defined);
use Fancy::Open qw(fancy_open);
use Page::Data qw(make_hash);
use Page::File qw(file_directory);
use Page::HTML qw(list span anchor object figure);
use Page::Line qw(line);
use Page::Convert qw(searchify);
use Random::Body::Modification qw(random_body_modification);
use Random::Color      qw(random_color);
use Random::Descriptor qw(random_descriptor);
use Random::Misc       qw(random_sexual_orientation random_relationship);

our $VERSION   = "1.0";
our @EXPORT_OK = qw(misc_magic);

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

# Version 1.0
# Depends on Page::Convert, Page::Data, Page::File, Page::HTML, Page::Line, Fancy::Join::Defined, Fancy::Open, Random::Body::Modification, Random::Color, Random::Descriptor, Random::Misc, Lingua::EN::Inflect, and Exporter
# This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See https://dev.perl.org/licenses/artistic.html.
# Copyright © 2020, Lady Aleena (aleena@cpan.org). All rights reserved.

1;