import 'dart:convert';

ProfileResponse profileResponseFromJson(String str) =>
    ProfileResponse.fromJson(json.decode(str));

String profileResponseToJson(ProfileResponse data) =>
    json.encode(data.toJson());

class ProfileResponse {
  ExtensionData? extensionData;
  String? address;
  double? balance;
  String? city;
  String? country;
  int? currency;
  int? currentTradesCount;
  int? currentTradesVolume;
  double? equity;
  double? freeMargin;
  bool? isAnyOpenTrades;
  bool? isSwapFree;
  int? leverage;
  String? name;
  String? phone;
  int? totalTradesCount;
  int? totalTradesVolume;
  int? type;
  int? verificationLevel;
  String? zipCode;

  ProfileResponse({
    this.extensionData,
    this.address,
    this.balance,
    this.city,
    this.country,
    this.currency,
    this.currentTradesCount,
    this.currentTradesVolume,
    this.equity,
    this.freeMargin,
    this.isAnyOpenTrades,
    this.isSwapFree,
    this.leverage,
    this.name,
    this.phone,
    this.totalTradesCount,
    this.totalTradesVolume,
    this.type,
    this.verificationLevel,
    this.zipCode,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        extensionData: json["extensionData"] == null
            ? null
            : ExtensionData.fromJson(json["extensionData"]),
        address: json["address"],
        balance: json["balance"]?.toDouble(),
        city: json["city"],
        country: json["country"],
        currency: json["currency"],
        currentTradesCount: json["currentTradesCount"],
        currentTradesVolume: json["currentTradesVolume"],
        equity: json["equity"]?.toDouble(),
        freeMargin: json["freeMargin"]?.toDouble(),
        isAnyOpenTrades: json["isAnyOpenTrades"],
        isSwapFree: json["isSwapFree"],
        leverage: json["leverage"],
        name: json["name"],
        phone: json["phone"],
        totalTradesCount: json["totalTradesCount"],
        totalTradesVolume: json["totalTradesVolume"],
        type: json["type"],
        verificationLevel: json["verificationLevel"],
        zipCode: json["zipCode"],
      );

  Map<String, dynamic> toJson() => {
    "extensionData": extensionData?.toJson(),
    "address": address,
    "balance": balance,
    "city": city,
    "country": country,
    "currency": currency,
    "currentTradesCount": currentTradesCount,
    "currentTradesVolume": currentTradesVolume,
    "equity": equity,
    "freeMargin": freeMargin,
    "isAnyOpenTrades": isAnyOpenTrades,
    "isSwapFree": isSwapFree,
    "leverage": leverage,
    "name": name,
    "phone": phone,
    "totalTradesCount": totalTradesCount,
    "totalTradesVolume": totalTradesVolume,
    "type": type,
    "verificationLevel": verificationLevel,
    "zipCode": zipCode,
  };
}

class ExtensionData {
  ExtensionData();

  factory ExtensionData.fromJson(Map<String, dynamic> json) => ExtensionData();

  Map<String, dynamic> toJson() => {};
}
