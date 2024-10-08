class WorkingTimeModel {
  WorkingTimeModel({
    required this.workDay,
    required this.from,
    required this.to,
    required this.is24Hours,
  });

  final int workDay;
  final String from;
  final String to;
  final bool is24Hours;

  WorkingTimeModel copyWith({
    int? workDay,
    String? from,
    String? to,
    bool? is24Hours,
  }) {
    return WorkingTimeModel(
      workDay: workDay ?? this.workDay,
      from: from ?? this.from,
      to: to ?? this.to,
      is24Hours: is24Hours ?? this.is24Hours,
    );
  }

  factory WorkingTimeModel.fromJson(Map<String, dynamic> json) {
    return WorkingTimeModel(
      workDay: json["workDay"] ?? 0,
      from: json["from"] ?? "",
      to: json["to"] ?? "",
      is24Hours: json["is24Hours"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "workDay": workDay,
        "from": from,
        "to": to,
      };

  @override
  String toString() {
    return "$workDay, $from, $to, ";
  }
}
