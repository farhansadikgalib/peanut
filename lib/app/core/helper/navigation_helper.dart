import 'package:get/get.dart';

/// Navigation helper for consistent app navigation.
/// 
/// Wraps GetX navigation methods with cleaner API.

class NavigationHelper {
  NavigationHelper._();

  /// Navigate to a named route.
  /// Pushes a new route onto the navigation stack
  static Future<T?>? toNamed<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a named route and remove all previous routes.
  /// Useful for login/logout flows where you want to clear navigation history
  static Future<T?>? offAllNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments);
  }

  /// Navigate to a named route and remove the current route.
  /// Replaces current route without ability to go back
  static Future<T?>? offNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments);
  }

  /// Go back to the previous route.
  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  /// Go back until a specific route.
  static void backUntil(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  /// Check if we can go back.
  static bool canGoBack() {
    return Get.key.currentState?.canPop() ?? false;
  }

  /// Get current route name.
  static String? get currentRoute => Get.currentRoute;

  /// Get previous route name.
  static String? get previousRoute => Get.previousRoute;

  /// Get route arguments.
  static dynamic get arguments => Get.arguments;

  /// Get route parameters.
  static Map<String, String?> get parameters => Get.parameters;

  /// Close all dialogs, bottomsheets, and snackbars.
  /// Useful for cleanup before navigation or when resetting UI state
  static void closeOverlays() {
    // Close any open dialogs
    if (Get.isDialogOpen ?? false) Get.back();
    // Close any open bottom sheets
    if (Get.isBottomSheetOpen ?? false) Get.back();
    // Dismiss all snackbar notifications
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();
  }
}
