
import 'package:splitwise/stores/user_store.dart';

import '../models/expense_model.dart';

List<ExpenseModel> filterFunction({required List<ExpenseModel> input, required String type, required String type2})
{
  List<ExpenseModel> output=[];
  output.addAll(input);
  output.retainWhere((element){
   if(element.type == type)
     {
       return true;
     }
   else if(type == 'All')
     {
       return true;
     }
   return false;
  });

  output.retainWhere((element){
    if(type2 == 'All')
    {
      return true;
    }
    else if(type2 == 'You Owe' && element.paidBy != UserStore.uid)
      {
        if(element.expenseID.startsWith('GSExpense'))
          {
            return false;
          }
        return true;
      }
    else if(type2 == 'You are owed' && element.paidBy == UserStore.uid)
      {
        if(element.expenseID.startsWith('GSExpense'))
        {
          return false;
        }
        return true;
      }
    return false;
  });
  print(output);


  return output;
}