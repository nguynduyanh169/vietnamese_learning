class Conversation {
  int id;
  String conversation;
  String description;
  String conversationImage;
  String voiceLink;
  String lessonID;
  bool status;

  Conversation(
      {this.id,
      this.conversation,
      this.description,
      this.conversationImage,
      this.voiceLink,
      this.lessonID,
      this.status});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
        id: json['id'],
        conversation: json['conversation'],
        description: json['description'],
        conversationImage: json['conversationImage'],
        voiceLink: json['voice_link'],
        lessonID: json['lessonID'],
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['conversation'] = this.conversation;
    data['description'] = this.description;
    data['conversationImage'] = this.conversationImage;
    data['voice_link'] = this.voiceLink;
    data['lessonID'] = this.lessonID;
    data['status'] = this.status;
    return data;
  }
}
