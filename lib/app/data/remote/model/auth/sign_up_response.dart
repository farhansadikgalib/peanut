import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  String? type;
  String? title;
  int? status;
  Data? data;
  String? message;

  SignUpResponse({
    this.type,
    this.title,
    this.status,
    this.data,
    this.message,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    type: json["type"],
    title: json["title"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "title": title,
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  User? user;
  String? token;
  Subscription? subscription;

  Data({
    this.user,
    this.token,
    this.subscription,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "subscription": subscription?.toJson(),
  };
}

class Subscription {
  Plan? plan;
  String? status;

  Subscription({
    this.plan,
    this.status,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "plan": plan?.toJson(),
    "status": status,
  };
}

class Plan {
  int? id;
  String? name;
  String? slug;
  String? price;

  Plan({
    this.id,
    this.name,
    this.slug,
    this.price,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "price": price,
  };
}

class User {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? address;
  String? createdAt;

  User({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "address": address,
    "created_at": createdAt,
  };
}
