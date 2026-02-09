import 'package:shared_value/shared_value.dart';

/// Shared value helper for persistent app state management.

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
final SharedValue<String> userId = SharedValue(
  value: "",
  key: "userId",
);



