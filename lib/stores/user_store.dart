import '../functions/email_to_uid.dart';
import '../models/user_friends_model.dart';
import '../models/user_groups_model.dart';

class UserStore
{
  static String phoneNumber = "";
  static String uid = "";
  static String email = "";
  static String username = "";
  static List<String> activity = [];
  static Map<String,UserFriendModel> friends = {};
  static Map<String,UserGroupModel> groups = {};

  static void initialise(Map<String,dynamic> data)
  {

    phoneNumber = data['phoneNumber'];
    email = data['email'];
    username = data['username'];
    uid = data['uid'];

    List<String> temp1 = [];

    for(String x in data['activity'])
      {
        temp1.add(x);
      }
    Map<String,UserFriendModel> temp2 = {};
    for(String x in (data['friends'] as Map<String,dynamic>).keys)
    {

      temp2[x] = UserFriendModel.fromJson(data['friends'][x]);

    }


    Map<String,UserGroupModel> temp3 = {};
    for(String x in data['groups'].keys)
    {
      try {
        temp3[x] = UserGroupModel.fromJson(data['groups'][x]);
      }
      catch(e)
    {
      print(e);
    }
    }
    activity = temp1;
    friends = temp2;
    groups = temp3;
  }

  static void clear()
  {
    phoneNumber = "";
    email ="";
    username = "";
    uid = "";
    activity = [];
    friends = {};
    groups = {};

  }

  static List<String> getFriends()
  {
    List<String> e = [];
    for(String key in friends.keys)
      {
        e.add(UIDN(key));
      }
    return e;

  }




}
