import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../connectivity/connectivity_manager_controller.dart';
import '../style/app_colors.dart';
import '../style/app_style.dart';
import 'base_controller.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  BaseView({super.key});

  /// Connection controller for monitoring network status
  final _connectionController = Get.find<ConnectionManagerController>();

  /// Optional app bar for the screen
  PreferredSizeWidget? appBar(BuildContext context);

  /// Required body content for the screen
  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Dismiss keyboard when tapping outside text fields
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        //sets ios status bar color
        backgroundColor: AppColors.white,
        // key: controller.globalKey,
        appBar: appBar(context),
        floatingActionButton: floatingActionButton(),
        bottomNavigationBar: bottomNavigationBar(context),
        drawer: drawer(context),
        body: pageScaffold(context),
      ),
    );
  }

  // Scaffold Widgets
  /// Wraps the page content in a SafeArea with expanded body
  Widget pageScaffold(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Column(children: [Expanded(child: pageContent(context))]),
    );
  }

  /// Returns the main page content
  Widget pageContent(BuildContext context) {
    return body(context);
  }

  /// Optional bottom navigation bar (shows connection status when offline)
  Widget? bottomNavigationBar(BuildContext context) {
    return Obx(() {
      // Show connection status bar only when offline
      return _connectionController.isInternetConnected.value
          ? const SizedBox.shrink()
          : BottomAppBar(child: connectionStatusView() ?? const SizedBox());
    });
  }

  Widget? drawer(BuildContext context) {
    return null;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? connectionStatusView() {
    return Container(
      width: double.infinity,
      height: 30,
      padding: REdgeInsets.symmetric(horizontal: 16),
      color: AppColors.primaryColor,
      child: Center(
        child: Text(
          _connectionController.connectedStatusMessage.value,
          style: textRegularStyle(isWhiteColor: true),
        ),
      ),
    );
  }
}
