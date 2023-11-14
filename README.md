# Advent of Code 2015

Advent of Code is a series of daily [programming puzzles](https://adventofcode.com/) during the advent time.

## Prerequisites for running a solution

- dart is installed and in your path
- the input for day x is available in the `input` directory (example for day 1: `input/1.txt`)

  you can generate the input files using `dart run _archive/generate.dart`

## running a solution

> example for day 1:
>
> `dart run lib/day01.dart`

## quickstart for a new day

- (once) create a new file `_archive/cookie.secret` and save your session cookie in it => `session=...`
- run `dart run _archive/daily_setup.dart` to generate the input and code files for the current day
- run `dart run _archive/daily_setup.dart <day>` to generate the input and code files for a specific day in the past (e.g. replace `<day>` with `5`)
