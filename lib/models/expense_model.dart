// To parse this JSON data, do
//     final welcome8 = welcome8FromJson(jsonString);

import 'dart:convert';

ExpenseModel ExpenseModelFromJson(String str) => ExpenseModel.fromJson(json.decode(str));

String ExpenseModelToJson(ExpenseModel data) => json.encode(data.toJson());

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.paidBy,
    required this.amount,
    required this.expenseId,
    required this.date,
    required this.owe,
  });

  String title;
  String paidBy;
  double amount;
  String expenseId;
  String date;
  Map<String, double> owe;

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    title: json["title"],
    paidBy: json["paidBy"],
    amount: json["amount"].toDouble(),
    expenseId: json["expenseID"],
    date: json["date"],
    owe: Map.from(json["owe"]).map((k, v) => MapEntry<String, double>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "paidBy": paidBy,
    "amount": amount,
    "expenseID": expenseId,
    "date": date,
    "owe": Map.from(owe).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}
