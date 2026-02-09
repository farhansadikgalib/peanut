import 'package:get/get.dart';
import 'package:logger/logger.dart';

var logger = Logger();

/// Default page transition animation style
const Transition transition = Transition.cupertino;

/// Duration for page transitions in milliseconds
const transitionDuration = 300;

/// OTP resend cooldown duration in seconds
const otpResendDuration = 60;

// UI Dimension Constants
/// Corner radius for buttons
const buttonCornerRadius = 20.0;

/// Left-right padding for main layouts
const layoutLRPadding = 24.0;

/// Standard button height
const buttonHeight = 64.0;

/// Left-right padding for buttons
const buttonLRPadding = 26.0;

/// Standard corner radius for cards and containers
const cornerRadius = 10.0;

/// Corner radius for table elements
const tableRadius = 5.0;

/// Spacing from dropdown to title
const dropdownToTitle = 12.0;

/// Spacing from title to dropdown
const titleToDropdown = 5.0;

/// Main screen padding
const mainPadding = 20.0;

/// Alternative main padding (12px)
const mainPadding12 = 12.0;

/// Bottom padding for main action buttons
const mainButtonBottomPadding = 75.0;

/// Padding inside containers
const mainInsidePadding = 12.0;

/// Top-bottom padding inside containers
const mainInsideTopBottomPadding = 16.0;

/// App bar top padding
const appbarPadding = 70.0;

/// Height and width for back button icons
const backButtonHeightWidth = 24.0;

/// Estimated keyboard height for UI adjustments
const keyBoardHeight = 300.00;

// Logger Configuration
/// Maximum line length for logger output
const int loggerLineLength = 120;

/// Number of method calls to show in error stack traces
const int loggerErrorMethodCount = 8;

/// Number of method calls to show in normal logs
const int loggerMethodCount = 2;
