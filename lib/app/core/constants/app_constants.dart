import 'package:get/get.dart';
import 'package:logger/logger.dart';

var logger = Logger();

/// Default page transition animation style
const Transition transition = Transition.cupertino;

/// Duration for page transitions in milliseconds
const transitionDuration = 300;

// UI Dimension Constants
/// Standard corner radius for cards and containers
const cornerRadius = 10.0;

/// Padding inside containers
const mainInsidePadding = 12.0;

// Logger Configuration
/// Maximum line length for logger output
const int loggerLineLength = 120;

/// Number of method calls to show in error stack traces
const int loggerErrorMethodCount = 8;

/// Number of method calls to show in normal logs
const int loggerMethodCount = 2;
