import 'dart:convert';

LastFourNumberResponse lastFourNumberResponseFromJson(String str) =>
    LastFourNumberResponse.fromJson(json.decode(str));

String lastFourNumberResponseToJson(LastFourNumberResponse data) =>
    json.encode(data.toJson());

class LastFourNumberResponse {
  String? lastFourNumber;

  LastFourNumberResponse({
    this.lastFourNumber,
  });

  factory LastFourNumberResponse.fromJson(Map<String, dynamic> json) =>
      LastFourNumberResponse(
        lastFourNumber: json["lastFourNumber"],
      );

  Map<String, dynamic> toJson() => {
        "lastFourNumber": lastFourNumber,
      };

  /// Helper method to get masked display format
  /// Example: "********5520"
  String getMaskedDisplay() {
    if (lastFourNumber == null || lastFourNumber!.isEmpty) {
      return '';
    }
    return '********$lastFourNumber';
  }

  /// Helper method to get just the last 4 digits
  /// Example: "5520"
  String getLastFourDigits() {
    return lastFourNumber ?? '';
  }
}
