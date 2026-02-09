import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_value/shared_value.dart';

import 'app/core/binding/initial_binding.dart';
import 'app/core/constants/app_constants.dart';
import 'app/core/style/app_colors.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.edgeToEdge,
          overlays: [SystemUiOverlay.bottom],
        );

        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        );

        return SharedValue.wrapApp(
          GetMaterialApp(
            title: "YSpark",
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            builder: EasyLoading.init(),
            theme: ThemeData(
              useMaterial3: false,
              canvasColor: Colors.white,
              primaryColor: AppColors.primaryColor,
            ),
            defaultTransition: transition,
            getPages: AppPages.routes,
            enableLog: kDebugMode,
          ),
        );
      },
    ),
  );
}

