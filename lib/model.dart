import 'package:cloud_firestore/cloud_firestore.dart';

class NewsContent {
  final String content;
  final String description;
  final String title;

  NewsContent({
    required this.content,
    required this.description,
    required this.title,
  });

  factory NewsContent.fromMap(Map<String, dynamic> map) {
    // Handle nested map structure
    if (map['content'] is Map) {
      return NewsContent(
        content: map['content']['bn'] ?? '',
        description: map['description']['bn'] ?? '',
        title: map['title']['bn'] ?? '',
      );
    }

    // Handle direct string values
    return NewsContent(
      content: map['content'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'description': description,
      'title': title,
    };
  }
}

class NewsArticle {
  final String id;
  final NewsContent data;
  final NewsContent data_bn;
  final String publishDate;
  final DateTime publishedAt;
  final String urlToImage;

  NewsArticle({
    required this.id,
    required this.data,
    required this.data_bn,
    required this.publishDate,
    required this.publishedAt,
    required this.urlToImage,
  });

  factory NewsArticle.fromMap(Map<String, dynamic> map, String id) {
    try {
      return NewsArticle(
        id: id,
        data: NewsContent.fromMap({
          'content': map['content'] ?? '',
          'description': map['description'] ?? '',
          'title': map['title'] ?? '',
        }),
        data_bn: NewsContent.fromMap({
          'content': map['data_bn']?['content'] ?? map['content_bn'] ?? '',
          'description':
              map['data_bn']?['description'] ?? map['description_bn'] ?? '',
          'title': map['data_bn']?['title'] ?? map['title_bn'] ?? '',
        }),
        publishDate: map['publishDate'] ?? '',
        publishedAt: (map['publishedAt'] as Timestamp).toDate(),
        urlToImage: map['urlToImage'] ?? '',
      );
    } catch (e) {
      print('Error parsing NewsArticle: $e');
      print('Problematic map: $map');
      rethrow;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'content': data.content,
      'description': data.description,
      'title': data.title,
      'data_bn': {
        'content': data_bn.content,
        'description': data_bn.description,
        'title': data_bn.title,
      },
      'publishDate': publishDate,
      'publishedAt': Timestamp.fromDate(publishedAt),
      'urlToImage': urlToImage,
    };
  }
}
