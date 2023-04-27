class UserGroupModel {
  UserGroupModel({
    required this.title,
    required this.owe,
    required this.groupID,
  });
  late final String title;
  late final double owe;
  late final String groupID;

  UserGroupModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    owe = json['owe'] * 1.0;
    groupID = json['groupID'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['owe'] = owe;
    _data['groupID'] = groupID;
    return _data;
  }
}