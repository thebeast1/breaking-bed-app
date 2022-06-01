import 'package:breaking_bed/data/models/char_quote.dart';
import 'package:breaking_bed/data/models/character.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded({this.characters});
}

class QuotesLoaded extends CharactersState {
  final List<Quote> quotes;

  QuotesLoaded({this.quotes});
}
