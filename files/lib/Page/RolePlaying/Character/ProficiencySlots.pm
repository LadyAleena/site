package Page::RolePlaying::Character::ProficiencySlots;
use v5.8.8;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(proficiency_slots);

use Page::RolePlaying::Character::Class qw(convert_class class_level);

my %slots;
while (my $line = <DATA>) {
  chomp $line;
  my ($class, $weapon, $nonweapon) = split(/\|/, $line);
  my @slot_stats = qw(initial frequency);
  @{$slots{$class}{'weapon'}}{@slot_stats}     = split(/;/, $weapon);
  @{$slots{$class}{'non-weapon'}}{@slot_stats} = split(/;/, $nonweapon);
}

sub proficiency_slots {
  my ($class, $opt) = @_;
  $class = convert_class($class,'ProficiencySlots');
  my $level = $opt->{'level'} ? $opt->{'level'} : class_level($class, $opt->{'experience'});

  my $slots;
  for my $type ('weapon','non-weapon') {
    my $initial_slots = $slots{$class}{$type}{'initial'};
    my $frequency     = $slots{$class}{$type}{'frequency'};

    my $multiplier = int($level / $frequency);

    if ($opt->{'by the book'}) {
      $slots->{$type} = $initial_slots + $multiplier;
    }
    else {
      $slots->{$type} = $initial_slots + ($initial_slots * $multiplier);
    }
  }
  $slots->{'languages'} = $opt->{'# of languages'} if $opt->{'# of languages'};

  return $slots;
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;

__DATA__
warrior|4;3|3;3
rogue|2;4|3;4
priest|2;4|4;3
wizard|1;6|4;3
psionisist|2;5|3;3
chaos warden|4;6|4;4
theopsyelementalist|2;6|4;3