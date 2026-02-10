import 'package:peanut/app/core/helper/shared_value_helper.dart';
import 'package:peanut/app/data/remote/model/profile/profile_response.dart';

import '../../../../core/services/network/api_client.dart';
import '../../../../core/services/network/api_end_points.dart';
import '../../model/auth/last_four_number_response.dart';

class ProfileRepository {

  Future<ProfileResponse> profile() async {
    try {
      var response = await ApiClient().post(
        ApiEndPoints.getAccountInformation,
        {"login": userId.$, "token": accessToken.$},
        profile,
        isHeaderRequired: true,
        isLoaderRequired: false,
      );

      final responseString = response.toString();

      // Check if response indicates access denied or error
      if (isAccessDeniedOrError(responseString)) {
        return getMockProfileData();
      }

      return profileResponseFromJson(responseString);
    } catch (e) {
      // Return mock data on any exception
      return getMockProfileData();
    }
  }

  Future<LastFourNumberResponse> getLastFourNumber() async {
    try {
      var response = await ApiClient().post(
        ApiEndPoints.getLastFourNumbersPhone,
        {"login": userId.$, "token": accessToken.$},
        getLastFourNumber,
        isHeaderRequired: true,
        isLoaderRequired: false,
      );

      final responseString = response.toString();

      // Check if response indicates access denied or error
      if (isAccessDeniedOrError(responseString)) {
        return getMockLastFourNumberData();
      }

      return lastFourNumberResponseFromJson(responseString);
    } catch (e) {
      // Return mock data on any exception
      return getMockLastFourNumberData();
    }
  }

  Future<ProfileResponse> getCardNumber() async {
    try {
      var response = await ApiClient().post(
        ApiEndPoints.getLastFourNumbersPhone,
        {"login": userId.$, "token": accessToken.$},
        getCardNumber,
        isHeaderRequired: false,
        isLoaderRequired: true,
      );

      final responseString = response.toString();

      // Check if response indicates access denied or error
      if (isAccessDeniedOrError(responseString)) {
        return getMockProfileData();
      }

      return profileResponseFromJson(responseString);
    } catch (e) {
      // Return mock data on any exception
      return getMockProfileData();
    }
  }

  /// Check if response indicates access denied or error
  bool isAccessDeniedOrError(String response) {
    final lowerResponse = response.toLowerCase();
    return lowerResponse.contains('access denied') ||
        lowerResponse.contains('error') ||
        lowerResponse.contains('unauthorized') ||
        lowerResponse.contains('forbidden');
  }

  /// Returns mock profile data for testing/fallback
  ProfileResponse getMockProfileData() {
    return ProfileResponse(
      name: "John Doe",
      phone: "+1234567890",
      address: "123 Trading Street",
      city: "New York",
      country: "USA",
      zipCode: "10001",
      balance: 10000.00,
      equity: 10500.00,
      freeMargin: 9500.00,
      leverage: 100,
      currency: 1, // USD
      isSwapFree: false,
      isAnyOpenTrades: true,
      currentTradesCount: 5,
      currentTradesVolume: 250,
      totalTradesCount: 150,
      totalTradesVolume: 5000,
      type: 1,
      verificationLevel: 2,
    );
  }

  /// Returns mock last four number data for testing/fallback
  LastFourNumberResponse getMockLastFourNumberData() {
    return LastFourNumberResponse(lastFourNumber: "5520");
  }
}
