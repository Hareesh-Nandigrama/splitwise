class UserFriendModel {
  UserFriendModel({
    required this.owes,
    required this.activity,
  });
  late final double owes;
  late final List<String> activity;

  UserFriendModel.fromJson(Map<String, dynamic> json){
    owes = json['owes'];
    activity = List.castFrom<dynamic, String>(json['activity']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['owes'] = owes;
    _data['activity'] = activity;
    return _data;
  }
}