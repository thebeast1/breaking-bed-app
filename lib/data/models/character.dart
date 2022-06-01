class Character {
  int charId;
  String name,
      nickname,
      image,
      statusIfDeadOrAlive,
      actorName,
      categoryForTwoSeries;

  List<dynamic> jobs;
  List<dynamic> appearanceOfSeasons;
  List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    nickname = json['nickname'];
    image = json['img'];
    statusIfDeadOrAlive = json['status'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    jobs = json['occupation'];
    appearanceOfSeasons = json['appearance'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
