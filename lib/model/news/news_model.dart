import 'dart:convert';
import 'package:flutter/foundation.dart';

class NewsModel {
  String status;
  int totalResults;
  List<Articles> articles;

  NewsModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  NewsModel copyWith({
    String? status,
    int? totalResults,
    List<Articles>? articles,
  }) {
    return NewsModel(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      'articles': articles.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      status: map['status'] as String? ?? 'unknown status',
      totalResults: map['totalResults'] as int? ?? 0,
      articles: List<Articles>.from(
        (map['articles'] as List<dynamic>?)?.map<Articles>(
              (x) => Articles.fromMap(x as Map<String, dynamic>),
            ) ??
            [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NewsModel(status: $status, totalResults: $totalResults, articles: $articles)';

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.totalResults == totalResults &&
        listEquals(other.articles, articles);
  }

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}

class Articles {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Articles({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Articles copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) {
    return Articles(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory Articles.fromMap(Map<String, dynamic> map) {
    return Articles(
      source: Source.fromMap(
          map['source'] as Map<String, dynamic>? ?? {'name': 'Unknown Source'}),
      author: map['author'] as String? ?? 'Unknown Author',
      title: map['title'] as String? ?? 'No Title',
      description: map['description'] as String? ?? 'No Description',
      url: map['url'] as String? ?? 'No URL',
      urlToImage: map['urlToImage'] as String? ?? 'No Image URL',
      publishedAt: map['publishedAt'] as String? ?? 'No Date',
      content: map['content'] as String? ?? 'No Content',
    );
  }

  String toJson() => json.encode(toMap());

  factory Articles.fromJson(String source) =>
      Articles.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Articles(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  @override
  bool operator ==(covariant Articles other) {
    if (identical(this, other)) return true;

    return other.source == source &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.content == content;
  }

  @override
  int get hashCode {
    return source.hashCode ^
        author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        content.hashCode;
  }
}

class Source {
  String name;

  Source({
    required this.name,
  });

  Source copyWith({
    String? name,
  }) {
    return Source(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      name: map['name'] as String? ?? 'Unknown Source',
    );
  }

  String toJson() => json.encode(toMap());

  factory Source.fromJson(String source) =>
      Source.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Source(name: $name)';

  @override
  bool operator ==(covariant Source other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
