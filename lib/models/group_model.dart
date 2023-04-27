import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  GroupModel({
    required this.title,
    required this.people,
    required this.creator,
    required this.expenses,
  });

  String title;
  List<String> people;
  String creator;
  List<String> expenses;

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    title: json["title"],
    people: List<String>.from(json["people"].map((x) => x)),
    creator: json["creator"],
    expenses: List<String>.from(json["expenses"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "people": List<dynamic>.from(people.map((x) => x)),
    "creator": creator,
    "expenses": List<dynamic>.from(expenses.map((x) => x)),
  };
}
