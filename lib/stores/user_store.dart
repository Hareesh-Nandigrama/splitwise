class UserStore
{
  static String username = '';
  static String email = '';
  static String phoneNumber= '';
  static List<String> friends = [];
  static List<String> groups = [];

  static void clear()
  {
    username = "";
    email = "";
    phoneNumber = "";
    friends = [];
    groups = [];
  }

  static void initialise(Map<String, dynamic> resp)
  {
    email = resp['email'];
    username = resp['username'];
    phoneNumber = resp['phoneNumber'];
    List<String> t1 = [];
    resp['friends'].forEach((element) {t1.add(element as String);});
    List<String> t2 = [];
    resp['groups'].forEach((element) {t2.add(element as String);});
    friends = t1;
    groups = t2;
  }

  static Map<String, dynamic> getData()
  {
    return
        {
          'email': email,
          'username': username,
          'phoneNumber': phoneNumber,
          'friends': friends,
          'groups': groups,
        };
  }




}