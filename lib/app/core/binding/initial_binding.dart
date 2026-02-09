import 'package:get/get.dart';
import '../connectivity/connectivity_manager_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    ConnectionManagerBinding().dependencies();
    // Get.put(HomeController(), permanent: true);
    // Get.put(SignUpController(), permanent: true);
  }
}
