import 'package:peanut/app/data/remote/model/auth/login_response.dart';

import 'shared_value_helper.dart';

/// Authentication helper for managing user session data.

class AuthHelper {
  void setUserData(LoginResponse loginResponse) {
    if (loginResponse.token != null) {
      // Set logged in flag
      isLoggedIn.$ = true;
      isLoggedIn.save();

      // Store access token with Bearer prefix for API calls
      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();
    }
  }

  void clearUserData() {
    // Reset login flag
    isLoggedIn.$ = false;
    isLoggedIn.save();

    // Clear authentication token
    accessToken.$ = "";
    accessToken.save();

    // Clear user profile data
    userId.$ = "";
    userId.save();
  }

  /// Should be called on app startup to restore user session.
  void loadItems() {
    isLoggedIn.load();
    accessToken.load();
    userId.load();
  }
}
