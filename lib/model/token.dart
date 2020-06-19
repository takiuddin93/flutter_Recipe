import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  Token({
    this.response,
    this.result,
  });

  String response;
  Result result;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        response: json["response"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    this.token,
  });

  String token;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
