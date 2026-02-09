import 'package:shared_value/shared_value.dart';

/// Shared value helper for persistent app state management.
/// 
/// Uses shared_value package to store and sync data across the app
/// with automatic persistence to local storage.

// Authentication State
/// Flag indicating if user is currently logged in
final SharedValue<bool> isLoggedIn = SharedValue(
  value: false,
  key: "isLoggedIn",
);

/// JWT access token with Bearer prefix for API authentication
final SharedValue<String> accessToken = SharedValue(
  value: "",
  key: "accessToken",
);

// User Profile Data
/// User's email address
final SharedValue<String> userEmail = SharedValue(
  value: "",
  key: "userEmail",
);

/// User's phone number
final SharedValue<String> userPhone = SharedValue(
  value: "",
  key: "userPhone",
);

/// User's full name
final SharedValue<String> userName = SharedValue(value: "", key: "userName");

/// Unique user identifier
final SharedValue<String> userId = SharedValue(value: "", key: "staffID");

/// User's role in the system
final SharedValue<String> userRole = SharedValue(value: "", key: "userRole");

// User Role Flags
/// Flag indicating if user has manager permissions
final SharedValue<bool> isManager = SharedValue(value: false, key: "isManager");

/// Flag indicating if user has supervisor permissions
final SharedValue<bool> isSupervisor = SharedValue(
  value: false,
  key: "isSupervisor",
);

/// Flag indicating if user has operator permissions
final SharedValue<bool> isOperator = SharedValue(
  value: false,
  key: "isOperator",
);

// Notification Settings
/// Master toggle for all notifications
final SharedValue<bool> notificationsEnabled = SharedValue(
  value: true,
  key: "notificationsEnabled",
);

/// Toggle for order-related notifications
final SharedValue<bool> orderNotifications = SharedValue(
  value: true,
  key: "orderNotifications",
);

/// Toggle for promotional and marketing notifications
final SharedValue<bool> promotionalNotifications = SharedValue(
  value: true,
  key: "promotionalNotifications",
);

/// Toggle for delivery status notifications
final SharedValue<bool> deliveryNotifications = SharedValue(
  value: true,
  key: "deliveryNotifications",
);

/// Toggle for new product arrival notifications
final SharedValue<bool> newArrivalsNotifications = SharedValue(
  value: true,
  key: "newArrivalsNotifications",
);

