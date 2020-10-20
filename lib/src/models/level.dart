class Level {
  int levelId;
  String levelName;
  bool status;

  Level({this.levelId, this.levelName, this.status});

  Level.fromJson(Map<String, dynamic> json){
    levelId = json['levelId'];
    levelName = json['levelName'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelId'] = this.levelId;
    data['levelName'] = this.levelName;
    data['status'] = this.status;
  }
}