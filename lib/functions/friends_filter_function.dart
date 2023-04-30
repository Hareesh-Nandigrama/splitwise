
import 'package:splitwise/models/user_friends_model.dart';

import '../models/expense_model.dart';

Map<String,UserFriendModel> filterFriendsFunction({required Map<String,UserFriendModel> input, required String type})
{
  Map<String,UserFriendModel> output= {};
  if(type == 'All')
    {
      return input;
    }

  for(var key in input.keys)
    {
   if(type == 'You Owe')
  {
    if(input[key]!.owe < 0)
      {
        output[key] = input[key]!;
      }
  }
  else if(type == 'Who Owe You')
  {
    if(input[key]!.owe > 0) {
      output[key] = input[key]!;
    }
  }
  else
  {
    if(input[key]!.owe == 0) {
      output[key] = input[key]!;
    }
  }
    }





  return output;
}