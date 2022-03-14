class LeaderBoardModel {
  LeaderBoardModel(
      {required this.user, required this.score, required this.time});

  LeaderBoardModel.fromJson(Map<String, Object?> json)
      : this(
          user: json['login']! as String,
          score: json['score']! as String,
          time: json['time']! as String,
        );

  String? user;
  String? score;
  String? time;

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'score': score,
      'time': time,
    };
  }
}
