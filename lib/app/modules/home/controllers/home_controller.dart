import 'package:get/get.dart';

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
  final totalProfit = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// Load initial data (profile and trades)
  Future<void> loadInitialData() async {
    isLoading.value = true;
    try {
      await Future.wait([
        fetchProfile(),
        fetchTrades(),
      ]);
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch user profile
  Future<void> fetchProfile() async {
    try {
      final response = await _profileRepository.profile();
      profile.value = response;
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  /// Fetch open trades
  Future<void> fetchTrades() async {
    try {
      final response = await _homeRepository.getOpenTrades();
      trades.value = response.trades ?? [];
      calculateTotalProfit();
    } catch (e) {
      print('Error fetching trades: $e');
      trades.value = [];
      totalProfit.value = 0.0;
    }
  }

  /// Refresh trades (pull to refresh)
  Future<void> refreshTrades() async {
    isRefreshing.value = true;
    try {
      await Future.wait([
        fetchProfile(),
        fetchTrades(),
      ]);
    } finally {
      isRefreshing.value = false;
    }
  }

  /// Calculate total profit from all trades
  void calculateTotalProfit() {
    if (trades.isEmpty) {
      totalProfit.value = 0.0;
      return;
    }
    totalProfit.value = trades.fold(0.0, (sum, trade) => sum + (trade.profit ?? 0.0));
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
