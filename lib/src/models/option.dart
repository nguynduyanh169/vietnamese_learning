class Option{
  int optionID;
  String optionName;
  bool checkCorrect;
  bool status;

  Option.fromJson(Map<String, dynamic> json){
    optionID = json['optionID'];
    optionName = json['optionName'];
    checkCorrect = json['checkCorrect'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optionID'] = this.optionID;
    data['optionName'] = this.optionName;
    data['checkCorrect'] = this.checkCorrect;
    data['status'] = this.status;
  }


}