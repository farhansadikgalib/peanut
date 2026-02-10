import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? result;
  String? token;

  LoginResponse({this.result, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      LoginResponse(result: json["result"], token: json["token"]);

  Map<String, dynamic> toJson() => {"result": result, "token": token};
}
