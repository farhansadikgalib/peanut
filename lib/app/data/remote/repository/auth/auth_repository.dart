import '../../../../core/services/network/api_client.dart';
import '../../../../core/services/network/api_end_points.dart';
import '../../model/auth/login_response.dart';

class AuthRepository {
  Future<LoginResponse> login(String login, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.isAccountCredentialsCorrect,
      {
        "login":  login,
        "password": password,
      },
      login,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return loginResponseFromJson(response.toString());
  }
}
