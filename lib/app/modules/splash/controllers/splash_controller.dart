import 'package:get/get.dart';

import '../../../core/helper/auth_helper.dart';

import '../../../core/helper/shared_value_helper.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    AuthHelper().loadItems();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await isLoggedIn.load().whenComplete(() async {
      Future.delayed(4.seconds).then((v) {
        if (isLoggedIn.$) {
          Get.offNamed(Routes.HOME);
        } else {
          AuthHelper().clearUserData();
          Get.offNamed(Routes.AUTH);
        }
      });
    });
  }
}
