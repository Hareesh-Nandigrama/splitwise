import 'package:splitwise/models/group_model.dart';

class GroupStore
{
  static Map<String, GroupModel> allgroups = {};
  static void clear()
  {
    allgroups = {};
  }

}

