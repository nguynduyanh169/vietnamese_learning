
class LoginResponse{
  String tokenType;
  String accessToken;

  LoginResponse({this.tokenType, this.accessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    tokenType = json['tokenType'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenType'] = this.tokenType;
    data['accessToken'] = this.accessToken;
    return data;
  }
}