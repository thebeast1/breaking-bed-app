import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bed/bussiness_logic/cubit/characters_cubit.dart';
import 'package:breaking_bed/bussiness_logic/cubit/characters_state.dart';
import 'package:breaking_bed/constants/my_colors.dart';
import 'package:breaking_bed/data/models/char_quote.dart';
import 'package:breaking_bed/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;

  const CharacterDetailsScreen({Key key,  this.character})
      : super(key: key);

  @override
  _CharacterDetailsScreenState createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getCharacterQuotes(widget.character.name);
  }

  Widget buildSilverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          widget.character.nickname,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: widget.character.charId,
          child: Image.network(
            widget.character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ]));
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndcator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    List<Quote> quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: MyColors.myWhite, shadows: [
            Shadow(
              blurRadius: 7,
              color: MyColors.myYellow,
              offset: Offset(0, 0),
            ),
          ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndcator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSilverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(
                        'Job : ',
                        widget.character.jobs.join(" / "),
                      ),
                      buildDivider(315),
                      characterInfo(
                        'Appeared in : ',
                        widget.character.categoryForTwoSeries,
                      ),
                      buildDivider(250),
                      characterInfo(
                        'seasons : ',
                        widget.character.appearanceOfSeasons.join(" / "),
                      ),
                      buildDivider(280),
                      characterInfo(
                        'Status : ',
                        widget.character.statusIfDeadOrAlive,
                      ),
                      buildDivider(300),
                      widget.character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Saul Seasons : ',
                              widget.character.betterCallSaulAppearance
                                  .join(" / "),
                            ),
                      widget.character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo(
                        'Job : ',
                        widget.character.jobs.join(" / "),
                      ),
                      buildDivider(315),
                      characterInfo(
                        'Actor/Actress : ',
                        widget.character.actorName,
                      ),
                      buildDivider(230),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                      SizedBox(
                        height: 500,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
