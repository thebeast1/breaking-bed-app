import 'package:breaking_bed/data/models/char_quote.dart';
import 'package:breaking_bed/data/models/character.dart';
import 'package:breaking_bed/data/web_services/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((c) => Character.fromJson(c)).toList();
  }

  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((q) => Quote.fromJson(q)).toList();
  }
}
