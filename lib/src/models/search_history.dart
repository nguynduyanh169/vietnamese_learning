import 'dart:convert';

class SearchHistory {
  SearchHistory({
    this.date,
    this.searchString,
  });

  DateTime date;
  String searchString;

  factory SearchHistory.fromJson(Map<String, dynamic> json) => SearchHistory(
    date: DateTime.parse(json["date"]),
    searchString: json["searchString"],
  );

  static Map<String, dynamic> toJson(SearchHistory searchHistory) => {
    "date": searchHistory.date.toIso8601String(),
    "searchString": searchHistory.searchString,
  };

  static String encoder(List<SearchHistory> searchHistory) => json.encode(
    searchHistory
        .map<Map<String, dynamic>>((searchHistory) => SearchHistory.toJson(searchHistory))
        .toList(),
  );

  static List<SearchHistory> decoder(String searchHistory) =>
      (json.decode(searchHistory) as List<dynamic>)
          .map<SearchHistory>((item) => SearchHistory.fromJson(item))
          .toList();
}