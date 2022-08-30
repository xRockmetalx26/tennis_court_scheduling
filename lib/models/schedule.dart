class Schedule {
  const Schedule(
      {required this.tennisCourt,
      required this.user,
      required this.date,
      required this.pop});

  Map<String, dynamic> toMap() =>
      {"tennis_court": tennisCourt, "user": user, "date": date, "pop": pop};

  Map<String, dynamic> toJson() => toMap();

  Schedule.fromJson(Map<String, dynamic> json)
      : tennisCourt = json["tennis_court"],
        user = json["user"],
        date = json["date"],
        pop = json["pop"];

  Schedule.fromMap(Map<String, dynamic> map)
      : tennisCourt = map["tennis_court"],
        user = map["user"],
        date = map["date"],
        pop = map["pop"];

  final String tennisCourt;
  final String user;
  final String date;
  final String pop;
}
