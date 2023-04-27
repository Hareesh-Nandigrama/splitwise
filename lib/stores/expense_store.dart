import '../models/expense_model.dart';

class ExpenseStore
{

  static Map<String, ExpenseModel> allexpenses = {};
  static void clear()
  {
    allexpenses = {};
  }

}

