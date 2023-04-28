class UserFriendModel {
  UserFriendModel({
    required this.owe,
    required this.activity,
  });
  late final double owe;
  late final List<String> activity;

  UserFriendModel.fromJson(Map<String, dynamic> json){
    owe = json['owe'];
    activity = List.castFrom<dynamic, String>(json['activity']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['owe'] = owe;
    _data['activity'] = activity;
    return _data;
  }
}