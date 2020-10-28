class User {
  String _username;
  String _password;
  String _email;

  User(this._username, this._password, this._email);

  User.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['password'] = this._password;
    data['email'] = this._email;
    return data;
  }

}
