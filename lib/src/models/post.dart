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
  Content(
      {this.id,
      this.numberOfComment,
      this.postDate,
      this.studentName,
      this.text,
      this.title,
      this.link,
      this.nation});

  int id;
  int numberOfComment;
  DateTime postDate;
  String studentName;
  String text;
  String title;
  String link;
  String nation;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      id: json["id"],
      numberOfComment: json["numberOfComment"],
      postDate: DateTime.parse(json["postDate"]),
      studentName: json["studentName"],
      text: json["text"],
      title: json["title"],
      link: json["link"],
      nation: json["nation"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "numberOfComment": numberOfComment,
        "postDate": postDate.toIso8601String(),
        "studentName": studentName,
        "text": text,
        "title": title,
        "link": link,
        "nation": nation,
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
