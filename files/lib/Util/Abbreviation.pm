package Util::Abbreviation;
use v5.8.8;
use strict;
use warnings FATAL => qw( all );
use Exporter qw(import);

our $VERSION   = '1.0';
our @EXPORT_OK = qw(abbr initials);

sub abbr {
  my %opt = @_;
  die("Sorry, I can't return an abbreviation if you don't give me a name.") if !$opt{'name'};

  my $name = $opt{'name'};
     $name =~ s/^(?:The|An?) //i if $opt{'article'} && $opt{'article'} eq 'drop';

  my $abbreviation;
  if ($name !~ /[ _-]/) {
    $abbreviation = $opt{'name'};
  }
  else {
    my @abbr;
    for my $word (split(/[ _-]/,$name)) {
      push @abbr, substr($word,0,1);
    }

    my $raw_abbr = $opt{'periods'} && $opt{'periods'} =~ /^[yt1]/i ? join('.',@abbr).'.' : join('',@abbr);
    my $final_abbr = $opt{'ALLCAPS'} && $opt{'ALLCAPS'} =~ /^[yt1]/i ? uc $raw_abbr : $raw_abbr;

    if ($opt{'HTML'} && $opt{'HTML'} =~ /^[yt1]/i) {
      $abbreviation = qq(<abbr title="$opt{name}">$final_abbr</abbr>);
    }
    else {
      $abbreviation = $final_abbr;
    }
  }

  return $abbreviation;
}

sub initials {
  abbr(@_);
}

=pod

=encoding utf8

=head1 Util::Abbreviation

B<Util::Abbreviation> returns an abbreviation for a string.

=head2 Version

This document describes Util::Abbreviation version 1.0.

=head2 Synopsis

  use Util::Abbreviation qw(abbr initial);

  my $abbr = abbr(
    name    => 'The Lady Aleena',
    article => 'drop',
    periods => 'no',
    ALLCAPS => 'yes',
    HTML    => 'no'
  );
  # LA

=head2 Description

In Util::Abbreviation C<abbr> and C<initial> can be exported. C<initial> is an alias for C<abbr>.

=over

=item name

C<name> is the name to be abbreviated. If the name does not have any spaces, underscores, or hyphens in it; it will be returned without being abbreviated.

=item article

C<article> is the option to C<drop> the article from the abbreviation. The World Wide Web would drop the article "The" and be abbriviated as WWW.

=item periods

C<periods> is the option to add periods to the abbreviation with yes, true, or 1. With it on John Doe would be abbreviated J.D.

=item ALLCAPS

C<ALLCAPS> is the option to make the abbreviation all capital letters. The International House of Pancakes would be abbreviated IHOP.

=item HTML

C<HTML> is the option to add the HTML C<<abbr>> tag to the abbreviation. Plain Old Documentation would be returned as follows:

  <abbr title="Plain Old Documentation">POD</abbr>

=back

=head2 Dependency

Util::Abbreviation depends on L<Exporter>.

=head2 Author

Lady Aleena

=cut

1;