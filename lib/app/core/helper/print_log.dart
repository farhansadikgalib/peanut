import 'package:flutter/foundation.dart';

import '../constants/app_constants.dart';

/// Log levels for controlling logging output.
/// Logging can be enabled to include all levels above certain [LogLevel].
enum LogLevel { verbose, debug, info, warning, error, wtf }

/// Configuration constants for logging behavior
const bool showAllDebug = true;
const String singleKey = "112324";

/// Logs a message with the specified level.
///
/// [message] - The message to log (can be any type)
/// [level] - Log level: "v" (verbose), "d" (debug), "i" (info),
///           "w" (warning), "e" (error), "wtf" (critical)
/// [key] - Optional key for filtering specific logs
///
/// Only logs in debug mode to prevent production log leaks.
void printLog(dynamic message, {String level = "i", String key = "1"}) {
  // Only log in debug mode to prevent production logging
  if (!kDebugMode) return;
  // Filter logs based on debug configuration
  if (!showAllDebug || singleKey == key) return;

  try {
    // Route message to appropriate log level
    switch (level.toLowerCase()) {
      case "v":
        // Verbose - detailed tracing
        logger.t(message);
        break;
      case "i":
        // Info - general information
        logger.i(message);
        break;
      case "w":
        // Warning - potential issues
        logger.w(message);
        break;
      case "e":
        // Error - error conditions
        logger.e(message);
        break;
      case "d":
        // Debug - debugging information
        logger.d(message);
        break;
      case "wtf":
        // Fatal - critical failures
        logger.f(message);
        break;
      default:
        // Default to debug level
        logger.d(message);
        break;
    }
  } catch (e) {
    // Fallback to basic print if logger fails
    debugPrint('[LOG] $message');
  }
}

/// Logs an error with stack trace support.
///
/// [message] - Error message or exception
/// [error] - Optional error object
/// [stackTrace] - Optional stack trace
///
/// Provides detailed error context including stack traces for debugging.
void printError(dynamic message, {Object? error, StackTrace? stackTrace}) {
  // Only log errors in debug mode
  if (!kDebugMode) return;

  try {
    // Use logger's error method with full context
    logger.e(message, error: error, stackTrace: stackTrace);
  } catch (e) {
    // Fallback to debugPrint if logger fails
    debugPrint('[ERROR] $message');
    if (error != null) debugPrint('[ERROR DETAILS] $error');
  }
}
