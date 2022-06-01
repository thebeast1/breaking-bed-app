import 'package:breaking_bed/data/models/character.dart';
import 'package:breaking_bed/data/repository/characters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository;
  List<Character> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters() {
    charactersRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters: characters));
      this.characters = characters;
    });

    return characters;
  }

  void getCharacterQuotes(String charName) {
    charactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes: quotes));
    });
  }
}
