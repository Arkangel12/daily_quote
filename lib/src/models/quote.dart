// To parse this JSON data, do
//
//     final quote = quoteFromJson(jsonString);

import 'dart:convert';

Quote quoteFromJson(String str) => Quote.fromJson(json.decode(str));

String quoteToJson(Quote data) => json.encode(data.toJson());

class Quote {
  Success success;
  Contents contents;
  String baseurl;
  Copyright copyright;

  Quote({
    this.success,
    this.contents,
    this.baseurl,
    this.copyright,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    success: Success.fromJson(json["success"]),
    contents: Contents.fromJson(json["contents"]),
    baseurl: json["baseurl"],
    copyright: Copyright.fromJson(json["copyright"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success.toJson(),
    "contents": contents.toJson(),
    "baseurl": baseurl,
    "copyright": copyright.toJson(),
  };
}

class Contents {
  List<QuoteElement> quotes;

  Contents({
    this.quotes,
  });

  factory Contents.fromJson(Map<String, dynamic> json) => Contents(
    quotes: List<QuoteElement>.from(json["quotes"].map((x) => QuoteElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "quotes": List<dynamic>.from(quotes.map((x) => x.toJson())),
  };
}

class QuoteElement {
  String quote;
  String length;
  String author;
  List<String> tags;
  String category;
  String language;
  DateTime date;
  String permalink;
  String id;
  String background;
  String title;

  QuoteElement({
    this.quote,
    this.length,
    this.author,
    this.tags,
    this.category,
    this.language,
    this.date,
    this.permalink,
    this.id,
    this.background,
    this.title,
  });

  factory QuoteElement.fromJson(Map<String, dynamic> json) => QuoteElement(
    quote: json["quote"],
    length: json["length"],
    author: json["author"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    category: json["category"],
    language: json["language"],
    date: DateTime.parse(json["date"]),
    permalink: json["permalink"],
    id: json["id"],
    background: json["background"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "quote": quote,
    "length": length,
    "author": author,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "category": category,
    "language": language,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "permalink": permalink,
    "id": id,
    "background": background,
    "title": title,
  };
}

class Copyright {
  int year;
  String url;

  Copyright({
    this.year,
    this.url,
  });

  factory Copyright.fromJson(Map<String, dynamic> json) => Copyright(
    year: json["year"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "url": url,
  };
}

class Success {
  int total;

  Success({
    this.total,
  });

  factory Success.fromJson(Map<String, dynamic> json) => Success(
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
  };
}
