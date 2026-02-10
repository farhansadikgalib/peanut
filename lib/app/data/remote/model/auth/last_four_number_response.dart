import 'dart:convert';

LastFourNumberResponse lastFourNumberResponseFromJson(String str) =>
    LastFourNumberResponse.fromJson(json.decode(str));

String lastFourNumberResponseToJson(LastFourNumberResponse data) =>
    json.encode(data.toJson());

class LastFourNumberResponse {
  String? lastFourNumber;

  LastFourNumberResponse({this.lastFourNumber});

  factory LastFourNumberResponse.fromJson(Map<String, dynamic> json) =>
      LastFourNumberResponse(lastFourNumber: json["lastFourNumber"]);

  Map<String, dynamic> toJson() => {"lastFourNumber": lastFourNumber};

  String getMaskedDisplay() {
    if (lastFourNumber == null || lastFourNumber!.isEmpty) {
      return '';
    }
    return '********$lastFourNumber';
  }

  String getLastFourDigits() {
    return lastFourNumber ?? '';
  }
}
