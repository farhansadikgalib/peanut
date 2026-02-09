

import 'shared_value_helper.dart';


/// Authentication helper for managing user session data.
/// 
/// Handles storing and clearing user credentials and profile information
/// using the shared value helper for persistent storage.
class AuthHelper {
  /// Saves user data from login response to persistent storage.
  /// 
  /// Stores authentication token, user profile details, and login state.
  void setUserData( loginResponse) {
    if (loginResponse.data?.token != null) {
      // Set logged in flag
      isLoggedIn.$ = true;
      isLoggedIn.save();

      // Store access token with Bearer prefix for API calls
      accessToken.$ = "Bearer ${loginResponse.data!.token}";
      accessToken.save();

      // Store user profile information
      userName.$ = loginResponse.data!.user!.name!;
      userName.save();

      userId.$ = loginResponse.data!.user!.id!.toString();
      userId.save();

      userEmail.$ = loginResponse.data!.user!.email!;
      userEmail.save();

      userPhone.$ = loginResponse.data!.user!.phone ?? "";
      userPhone.save();
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

    userName.$ = "";
    userName.save();

    userEmail.$ = "";
    userEmail.save();

    userPhone.$ = "";
    userPhone.save();
  }

  /// Loads all user data from persistent storage.
  /// 
  /// Should be called on app startup to restore user session.
  void loadItems() {
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    userId.load();
    userEmail.load();
    userPhone.load();
    userRole.load();
  }
}
