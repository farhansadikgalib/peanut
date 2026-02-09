import 'package:peanut/app/core/helper/shared_value_helper.dart';
import 'package:peanut/app/data/remote/model/profile/profile_response.dart';

import '../../../../core/services/network/api_client.dart';
import '../../../../core/services/network/api_end_points.dart';

class ProfileRepository {
  Future<ProfileResponse> profile() async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {
        "login":  userId.$,
        "token":  accessToken.$,
      },
      profile,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return profileResponseFromJson(response.toString());
  }
}
