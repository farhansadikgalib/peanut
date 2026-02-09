import 'package:get/get.dart';

import 'connectivity_manager_controller.dart';

class ConnectionManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConnectionManagerController(), fenix: true);
  }
}
