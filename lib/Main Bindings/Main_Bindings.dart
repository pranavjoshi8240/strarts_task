




import 'package:get/get.dart';

import '../Controller/ListDataController.dart';
import '../Controller/UserDataController.dart';


class MainBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    Get.lazyPut<GetDataConroller>(() => GetDataConroller(), fenix: true);
    Get.lazyPut<GetUserDataConroller>(() => GetUserDataConroller(), fenix: true);
  }

}