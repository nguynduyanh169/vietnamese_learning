class User_Gmail{
  String username;
  String avatarLink;
  String email;
  String fullname;
  String uid;

  User_Gmail(this.username, this.avatarLink, this.email, this.fullname, this.uid);

  User_Gmail.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullname = json['fullname'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['fullname'] = this.fullname;
    data['uid'] = this.uid;
    return data;
  }
}