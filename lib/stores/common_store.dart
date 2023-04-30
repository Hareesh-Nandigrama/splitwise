// ignore_for_file: library_private_types_in_public_api
import 'package:mobx/mobx.dart';

import '../constants/enums.dart';

part 'common_store.g.dart';

class CommonStore = _CommonStore with _$CommonStore;

abstract class _CommonStore with Store {

  @observable
  Pages page = Pages.groups;

  @observable
  int counter = 0;

  @observable
  String type = "All";

  @observable
  String type2 = "All";

  @action
  void setPage(Pages p) {
    page = p;
    type = "All";
    type2 = "All";
  }

  @action
  void reload(){
    counter++;
  }


}
