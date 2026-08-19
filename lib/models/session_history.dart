class SessionHistory {
  final String date;
  final int minutes;

  SessionHistory({required this.date, required this.minutes});

  Map<String, dynamic> toJson() {
    return {'date': date, 'minutes': minutes};
  }

  factory SessionHistory.fromJson(Map<String, dynamic> json) {
    return SessionHistory(date: json['date'], minutes: json['minutes']);
  }
}
