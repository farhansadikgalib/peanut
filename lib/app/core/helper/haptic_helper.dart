import 'package:flutter/services.dart';

/// Haptic feedback helper for tactile responses.
/// 
/// Provides easy-to-use methods for triggering haptic feedback
/// on supported devices.

class HapticHelper {
  HapticHelper._();

  /// Light haptic feedback - for subtle interactions.
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium haptic feedback - for standard interactions.
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy haptic feedback - for significant actions.
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection click feedback - for selection changes.
  static Future<void> selection() async {
    await HapticFeedback.selectionClick();
  }

  /// Vibrate feedback - standard vibration.
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }

  /// Success feedback pattern.
  /// Medium impact provides positive confirmation
  static Future<void> success() async {
    await HapticFeedback.mediumImpact();
  }

  /// Error feedback pattern.
  /// Heavy impact indicates something went wrong
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
  }

  /// Warning feedback pattern.
  /// Double light impact creates distinct warning sensation
  static Future<void> warning() async {
    await HapticFeedback.lightImpact();
    // Brief delay between taps for double-tap effect
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }
}
