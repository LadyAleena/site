# Date functions

All of these modules depend on [Exporter](https://metacpan.org/pod/Exporter).

## General date functions

These modules depend on [Date::Calc](https://metacpan.org/pod/Date::Calc).

* [Date::HalfLife](HalfLife.pm) returns when half a person's life has happened after an event.
* [Date::Verify](Verify.pm) makes sure the input matches the date criteria. It also depends on [Data::Validate](https://metacpan.org/pod/Data::Validate).

## Birth date functions

All of these modules depend on [String::Util](https://metacpan.org/pod/String::Util).

* [Date::Birth::DayStone](Birth/DayStone.pm) returns the birthday stone for the day of the week you were born. It also depends on [Date::Calc](https://metacpan.org/pod/Date::Calc).
* [Date::Birth::Flower](Birth/Flower.pm) returns the birth flower associated with months.
* [Date::Birth::Stone](Birth/Stone.pm) returns the birth stone associated with months.
* [Date::Birth::ZodiacStone](Birth/ZodiacStone.pm) returns the stone associated with zodiac signs.

## Month name function

* [Date::Month::Number](Month/Number.pm) returns the number for a month. The languages supported are English and the English abbreviations, Danish, Dutch, Finnish, French, German, Greek, Hungarian, Italian, Norwegian, Polish, Portuguese, Romanian, Russian, Spanish, and Swedish.