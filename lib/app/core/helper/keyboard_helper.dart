import 'package:flutter/material.dart';

/// Keyboard helper for managing keyboard visibility.
/// 
/// Provides utilities for hiding keyboard and checking keyboard state.

class KeyboardHelper {
  KeyboardHelper._();

  /// Hides the keyboard if it's currently visible.
  /// Requires BuildContext to access the current focus scope
  static void hide(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Hides keyboard using primary focus.
  /// Works without BuildContext by accessing global focus manager
  static void hideGlobal() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  /// Checks if keyboard is currently visible.
  /// Detects keyboard by checking bottom inset of MediaQuery
  static bool isVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Gets the current keyboard height.
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Requests focus on a specific focus node.
  /// Useful for programmatically focusing text fields
  static void requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  /// Moves focus to the next focusable widget.
  /// Respects tab order defined in the widget tree
  static void nextFocus(BuildContext context) {
    FocusScope.of(context).nextFocus();
  }

  /// Moves focus to the previous focusable widget.
  /// Navigates backward through the focus traversal order
  static void previousFocus(BuildContext context) {
    FocusScope.of(context).previousFocus();
  }
}
