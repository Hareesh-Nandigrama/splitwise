// To parse this JSON data, do
//     final welcome8 = welcome8FromJson(jsonString);

import 'dart:convert';


class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.paidBy,
   required this.amount,
   required this.expenseID,
    required this.date,
    required this.owe,
  });

  String title;
  String paidBy;
  double amount;
  String expenseID;
  DateTime date;
  Map<String, double> owe;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    title: json["title"],
    paidBy: json["paidBy"],
   amount: double.parse(json["amount"]),
   expenseID: json["expenseID"],
    date: DateTime.fromMillisecondsSinceEpoch(json['date'].seconds * 1000),
   owe: Map.from(json["owe"]).map((k, v) => MapEntry<String, double>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "paidBy": paidBy,
    "amount": amount,
    "expenseID": expenseID,
    "date": date,
    "owe": Map.from(owe).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
