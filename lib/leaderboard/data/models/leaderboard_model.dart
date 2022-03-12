class Cars {
  Cars({required this.user, required this.score, required this.time});

  Cars.fromJson(Map<String, Object?> json)
      : this(
          user: json['login']! as String,
          score: int.parse(json['score']! as String),
          time: int.parse(json['time']! as String),
        );

  String? user;
  int? score;
  int? time;

  Map<String, Object?> toJson() {
    return {
      'user': user,
      "score": score.toString(),
      'time': time.toString(),
    };
  }
}
