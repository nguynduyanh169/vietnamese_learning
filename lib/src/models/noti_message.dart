class NotiMessage {
  NotiMessage({
    this.from,
    this.collapseKey,
    this.clickAction,
    this.notification,
  });

  String from;
  String collapseKey;
  String clickAction;
  Notification notification;

  factory NotiMessage.fromJson(Map<dynamic, dynamic> json) => NotiMessage(
    from: json["from"],
    collapseKey: json["collapse_key"],
    clickAction: json["click_action"],
    notification: Notification.fromJson(json["notification"]),
  );

  Map<String, dynamic> toJson() => {
    "from": from,
    "collapse_key": collapseKey,
    "click_action": clickAction,
    "notification": notification.toJson(),
  };
}

class Notification {
  Notification({
    this.sound2,
    this.color,
    this.title,
    this.tag,
    this.sound,
    this.e,
    this.body,
  });

  String sound2;
  String color;
  String title;
  String tag;
  String sound;
  String e;
  String body;

  factory Notification.fromJson(Map<dynamic, dynamic> json) => Notification(
    sound2: json["sound2"],
    color: json["color"],
    title: json["title"],
    tag: json["tag"],
    sound: json["sound"],
    e: json["e"],
    body: json["body"],
  );

  Map<String, dynamic> toJson() => {
    "sound2": sound2,
    "color": color,
    "title": title,
    "tag": tag,
    "sound": sound,
    "e": e,
    "body": body,
  };
}