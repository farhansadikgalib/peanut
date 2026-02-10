import 'dart:convert';

TradeListResponse tradeListResponseFromJson(String str) =>
    TradeListResponse.fromJson(json.decode(str));

String tradeListResponseToJson(TradeListResponse data) =>
    json.encode(data.toJson());

class TradeListResponse {
  List<Trade>? trades;

  TradeListResponse({this.trades});

  factory TradeListResponse.fromJson(Map<String, dynamic> json) =>
      TradeListResponse(
        trades: json["trades"] == null
            ? []
            : List<Trade>.from(json["trades"].map((x) => Trade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "trades": trades == null
        ? []
        : List<dynamic>.from(trades!.map((x) => x.toJson())),
  };

  double getTotalProfit() {
    if (trades == null || trades!.isEmpty) return 0.0;
    return trades!.fold(0.0, (sum, trade) => sum + (trade.profit ?? 0.0));
  }

  int getProfitableTradesCount() {
    if (trades == null || trades!.isEmpty) return 0;
    return trades!.where((trade) => (trade.profit ?? 0.0) > 0).length;
  }

  int getLosingTradesCount() {
    if (trades == null || trades!.isEmpty) return 0;
    return trades!.where((trade) => (trade.profit ?? 0.0) < 0).length;
  }
}

class Trade {
  int? id;
  String? symbol;
  int? cmd; // 0 = Buy, 1 = Sell
  double? volume;
  double? openPrice;
  double? currentPrice;
  double? stopLoss;
  double? takeProfit;
  double? profit;
  double? commission;
  double? swap;
  String? openTime;
  String? comment;

  Trade({
    this.id,
    this.symbol,
    this.cmd,
    this.volume,
    this.openPrice,
    this.currentPrice,
    this.stopLoss,
    this.takeProfit,
    this.profit,
    this.commission,
    this.swap,
    this.openTime,
    this.comment,
  });

  factory Trade.fromJson(Map<String, dynamic> json) => Trade(
    id: json["id"],
    symbol: json["symbol"],
    cmd: json["cmd"],
    volume: json["volume"]?.toDouble(),
    openPrice: json["openPrice"]?.toDouble(),
    currentPrice: json["currentPrice"]?.toDouble(),
    stopLoss: json["stopLoss"]?.toDouble(),
    takeProfit: json["takeProfit"]?.toDouble(),
    profit: json["profit"]?.toDouble(),
    commission: json["commission"]?.toDouble(),
    swap: json["swap"]?.toDouble(),
    openTime: json["openTime"],
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "symbol": symbol,
    "cmd": cmd,
    "volume": volume,
    "openPrice": openPrice,
    "currentPrice": currentPrice,
    "stopLoss": stopLoss,
    "takeProfit": takeProfit,
    "profit": profit,
    "commission": commission,
    "swap": swap,
    "openTime": openTime,
    "comment": comment,
  };

  String getTradeType() {
    if (cmd == null) return "Unknown";
    return cmd == 0 ? "BUY" : "SELL";
  }

  bool isProfitable() {
    return (profit ?? 0.0) > 0;
  }

  String getProfitWithSign() {
    final profitValue = profit ?? 0.0;
    if (profitValue > 0) {
      return "+\$${profitValue.toStringAsFixed(2)}";
    } else if (profitValue < 0) {
      return "-\$${profitValue.abs().toStringAsFixed(2)}";
    }
    return "\$0.00";
  }
}
