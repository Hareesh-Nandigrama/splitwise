import 'expense_model.dart';

class GroupModel {
  GroupModel({
    required this.id,
    required this.title,
    required this.creator,
    required this.expenses,
    required this.balances,
  });

  String title;
  String id;
  String creator;
  List<ExpenseModel> expenses;
  Map<String,Map<String,double>> balances;

}
