import 'package:peanut/app/core/helper/shared_value_helper.dart';
import 'package:peanut/app/data/remote/model/home/trade_response.dart';

import '../../../../core/services/network/api_client.dart';
import '../../../../core/services/network/api_end_points.dart';

class HomeRepository {
  Future<TradeListResponse> getOpenTrades() async {
    try {
      var response = await ApiClient().post(
        ApiEndPoints.getOpenTrades,
        {"login": userId.$, "token": accessToken.$},
        getOpenTrades,
        isHeaderRequired: true,
        isLoaderRequired: false,
      );

      final responseString = response.toString();

      if (isAccessDeniedOrError(responseString)) {
        return getMockTradeData();
      }

      return tradeListResponseFromJson(responseString);
    } catch (e) {
      return getMockTradeData();
    }
  }

  bool isAccessDeniedOrError(String response) {
    final lowerResponse = response.toLowerCase();
    return lowerResponse.contains('access denied') ||
        lowerResponse.contains('error') ||
        lowerResponse.contains('unauthorized') ||
        lowerResponse.contains('forbidden');
  }

  TradeListResponse getMockTradeData() {
    return TradeListResponse(
      trades: [
        Trade(
          id: 12345,
          symbol: "EUR",
          cmd: 0, // BUY
          volume: 1.5,
          openPrice: 1.0850,
          currentPrice: 1.0920,
          stopLoss: 1.0800,
          takeProfit: 1.0950,
          profit: 1050.00,
          commission: -15.00,
          swap: -2.50,
          openTime: DateTime.now()
              .subtract(Duration(hours: 3))
              .toIso8601String(),
          comment: "Long position on EUR/USD",
        ),
        Trade(
          id: 12346,
          symbol: "GBP",
          cmd: 1, // SELL
          volume: 2.0,
          openPrice: 1.2650,
          currentPrice: 1.2680,
          stopLoss: 1.2700,
          takeProfit: 1.2600,
          profit: -600.00,
          commission: -20.00,
          swap: -3.00,
          openTime: DateTime.now()
              .subtract(Duration(hours: 5))
              .toIso8601String(),
          comment: "Short position on GBP/USD",
        ),
        Trade(
          id: 12347,
          symbol: "JPY",
          cmd: 0, // BUY
          volume: 1.0,
          openPrice: 149.50,
          currentPrice: 150.20,
          stopLoss: 149.00,
          takeProfit: 151.00,
          profit: 700.00,
          commission: -10.00,
          swap: -1.50,
          openTime: DateTime.now()
              .subtract(Duration(hours: 1))
              .toIso8601String(),
          comment: "USD/JPY bullish trend",
        ),
        Trade(
          id: 12348,
          symbol: "XAU",
          cmd: 0, // BUY
          volume: 0.5,
          openPrice: 2050.00,
          currentPrice: 2065.50,
          stopLoss: 2040.00,
          takeProfit: 2080.00,
          profit: 775.00,
          commission: -12.50,
          swap: -2.00,
          openTime: DateTime.now()
              .subtract(Duration(hours: 24))
              .toIso8601String(),
          comment: "Gold long position",
        ),
        Trade(
          id: 12349,
          symbol: "BTC",
          cmd: 1, // SELL
          volume: 0.1,
          openPrice: 43500.00,
          currentPrice: 43200.00,
          stopLoss: 44000.00,
          takeProfit: 42500.00,
          profit: 300.00,
          commission: -25.00,
          swap: 0.00,
          openTime: DateTime.now()
              .subtract(Duration(hours: 12))
              .toIso8601String(),
          comment: "BTC short position",
        ),
      ],
    );
  }
}
