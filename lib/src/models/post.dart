class PostSave {
  PostSave({
    this.link,
    this.postDate,
    this.text,
    this.title,
  });

  String link;
  String postDate;
  String text;
  String title;

  factory PostSave.fromJson(Map<String, dynamic> json) => PostSave(
        link: json["link"],
        postDate: json["postDate"],
        text: json["text"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "postDate": postDate,
        "text": text,
        "title": title,
      };
}

class Post {
  Post({
    this.content,
    this.empty,
    this.first,
    this.last,
    this.number,
    this.numberOfElements,
    this.pageable,
    this.size,
    this.sort,
    this.totalElements,
    this.totalPages,
  });

  List<Content> content;
  bool empty;
  bool first;
  bool last;
  int number;
  int numberOfElements;
  Pageable pageable;
  int size;
  Sort sort;
  int totalElements;
  int totalPages;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
        empty: json["empty"],
        first: json["first"],
        last: json["last"],
        number: json["number"],
        numberOfElements: json["numberOfElements"],
        pageable: Pageable.fromJson(json["pageable"]),
        size: json["size"],
        sort: Sort.fromJson(json["sort"]),
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
        "empty": empty,
        "first": first,
        "last": last,
        "number": number,
        "numberOfElements": numberOfElements,
        "pageable": pageable.toJson(),
        "size": size,
        "sort": sort.toJson(),
        "totalElements": totalElements,
        "totalPages": totalPages,
      };
}

class Content {
  Content({
    this.avatar,
    this.id,
    this.link,
    this.nation,
    this.numberOfComment,
    this.postDate,
    this.status,
    this.studentName,
    this.text,
    this.title,
  });

  String avatar;
  int id;
  String link;
  String nation;
  int numberOfComment;
  DateTime postDate;
  String status;
  String studentName;
  String text;
  String title;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    avatar: json["avatar"],
    id: json["id"],
    link: json["link"],
    nation: json["nation"],
    numberOfComment: json["numberOfComment"],
    postDate: DateTime.parse(json["postDate"]),
    status: json["status"],
    studentName: json["studentName"],
    text: json["text"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "avatar": avatar,
    "id": id,
    "link": link,
    "nation": nation,
    "numberOfComment": numberOfComment,
    "postDate": postDate.toIso8601String(),
    "status": status,
    "studentName": studentName,
    "text": text,
    "title": title,
  };
}

class Pageable {
  Pageable({
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.sort,
    this.unpaged,
  });

  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  Sort sort;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        sort: Sort.fromJson(json["sort"]),
        unpaged: json["unpaged"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "sort": sort.toJson(),
        "unpaged": unpaged,
      };
}

class Sort {
  Sort({
    this.empty,
    this.sorted,
    this.unsorted,
  });

  bool empty;
  bool sorted;
  bool unsorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
      );

  Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
      };
}

class PostUpdate {
  PostUpdate({
    this.link,
    this.postId,
    this.text,
    this.title,
  });

  String link;
  int postId;
  String text;
  String title;

  factory PostUpdate.fromJson(Map<String, dynamic> json) => PostUpdate(
    link: json["link"],
    postId: json["postID"],
    text: json["text"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
    "postID": postId,
    "text": text,
    "title": title,
  };
}
