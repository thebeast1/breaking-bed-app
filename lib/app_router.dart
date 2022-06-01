import 'package:breaking_bed/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bed/constants/strings.dart';
import 'package:breaking_bed/data/models/character.dart';
import 'package:breaking_bed/data/repository/characters_repository.dart';
import 'package:breaking_bed/data/web_services/characters_web_services.dart';
import 'package:breaking_bed/presentation/screens/character_details_screen.dart';
import 'package:breaking_bed/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  CharactersRepository charactersRepository;
  CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case KCharactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case KCharacterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) =>
                CharactersCubit(charactersRepository),
            child: CharacterDetailsScreen(
              character: character,
            ),
          ),
        );
      default:
    }
  }
}
