import 'dart:convert';

class ExpenseModel {
  ExpenseModel({
    required this.title, //group name
    required this.paidBy, //creator
   required this.amount,
   required this.expenseID,
    required this.date,    //date created
    required this.owe,
    required this.groupID,
    required this.type,
  });

  String title;
  String paidBy;
  String type;
  double amount;
  String expenseID;
  DateTime date;
  String groupID;
  Map<String, double> owe;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    title: json["title"],
    paidBy: json["paidBy"],
   amount: json["amount"],
   type: json["type"],
   expenseID: json["expenseID"],
    groupID: json["groupID"],
    date: DateTime.fromMillisecondsSinceEpoch(json['date'].seconds * 1000),
   owe: Map.from(json["owe"]).map((k, v) => MapEntry<String, double>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "paidBy": paidBy,
    "amount": amount,
    "expenseID": expenseID,
    "date": date,
    "groupID": groupID,
    "type": type,
    "owe": Map.from(owe).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
