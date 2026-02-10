import 'package:get/get.dart';

import '../../../data/remote/model/auth/last_four_number_response.dart';
import '../../../data/remote/model/home/trade_response.dart';
import '../../../data/remote/model/profile/profile_response.dart';
import '../../../data/remote/repository/home/home_repository.dart';
import '../../../data/remote/repository/profile/profile_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  // Observable variables
  final isLoading = false.obs;
  final isRefreshing = false.obs;
  final trades = <Trade>[].obs;
  final profile = Rxn<ProfileResponse>();
  final lastFourNumber = Rxn<LastFourNumberResponse>();
  final totalProfit = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  /// Load initial data (profile, card number, and trades)
  Future<void> loadInitialData() async {
    isLoading.value = true;
    await Future.wait([
      fetchProfile(),
      fetchLastFourNumber(),
      fetchTrades(),
    ]);
    isLoading.value = false;
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    profile.value = null;
    final response = await _profileRepository.profile();
    profile.value = response;
  }

  /// Fetch last four digits of phone/card
  Future<void> fetchLastFourNumber() async {
    lastFourNumber.value = null;
    final response = await _profileRepository.getLastFourNumber();
    lastFourNumber.value = response;
  }

  /// Fetch open trades
  Future<void> fetchTrades() async {
    trades.clear();
    totalProfit.value = 0.0;
    final response = await _homeRepository.getOpenTrades();
    trades.value = response.trades ?? [];
    calculateTotalProfit();
  }

  /// Refresh trades (pull to refresh)
  Future<void> refreshTrades() async {
    isRefreshing.value = true;
    await Future.wait([
      fetchProfile(),
      fetchLastFourNumber(),
      fetchTrades(),
    ]);
    isRefreshing.value = false;
  }

  /// Calculate total profit from all trades
  void calculateTotalProfit() {
    if (trades.isEmpty) {
      totalProfit.value = 0.0;
      return;
    }
    totalProfit.value = trades.fold(
      0.0,
      (sum, trade) => sum + (trade.profit ?? 0.0),
    );
  }

  /// Get count of profitable trades
  int getProfitableTradesCount() {
    return trades.where((trade) => (trade.profit ?? 0.0) > 0).length;
  }

  /// Get count of losing trades
  int getLosingTradesCount() {
    return trades.where((trade) => (trade.profit ?? 0.0) < 0).length;
  }

  /// Get formatted total profit with sign
  String getFormattedTotalProfit() {
    final profit = totalProfit.value;
    if (profit > 0) {
      return "+\$${profit.toStringAsFixed(2)}";
    } else if (profit < 0) {
      return "-\$${profit.abs().toStringAsFixed(2)}";
    }
    return "\$0.00";
  }
}
