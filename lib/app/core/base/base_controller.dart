import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'page_state.dart';

/// Base controller that all controllers should extend.
/// 
/// Provides common functionality like page state management, loading states,
/// and authentication tracking for consistent behavior across the app.
abstract class BaseController extends GetxController {
  // final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  /// Observable flag for authentication state
  final isAuthenticated = false.obs;
  
  /// Observable flag for background image requirement
  final isTopBgRequired = false.obs;
  
  /// Logger instance for debugging
  final logger = Logger();
  
  /// Observable page state controller
  final _pageSateController = PageState.defaultState.obs;
  
  // final  connectionController = Get.find<ConnectionManagerController>().obs;
  
  /// Getter for current page state
  PageState get pageState => _pageSateController.value;

  /// Updates the page state to a new value
  PageState updatePageState(PageState state) => _pageSateController(state);

  /// Resets page state to default
  PageState resetPageState() => _pageSateController(PageState.defaultState);

  /// Shows loading indicator by updating page state
  dynamic showLoading() => updatePageState(PageState.loading);

  /// Hides loading indicator by resetting page state
  dynamic hideLoading() => resetPageState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // // ----------drawer control -- start----------
  //
  //  openNavDrawer(){
  //     globalKey.currentState!.openDrawer();
  //  }
  //
  //  closeNavDrawer(){
  //    globalKey.currentState!.closeDrawer();
  //  }
  //
  // // ----------drawer control -- end----------
}
