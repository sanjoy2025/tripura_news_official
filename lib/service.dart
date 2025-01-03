import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripura_news_official_web/model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<NewsArticle>> getNewsArticles() {
    try {
      return _firestore
          .collection('news')
          .where('urlToImage', isNotEqualTo: null)
          .orderBy('publishedAt', descending: true)
          .limit(20)
          .snapshots()
          .map((snapshot) {
        try {
          return snapshot.docs
              .map((doc) {
                try {
                  return NewsArticle.fromMap(doc.data(), doc.id);
                } catch (e) {
                  print('Error parsing document ${doc.id}: $e');
                  // Return null for failed document parsing
                  return null;
                }
              })
              // Filter out null values from failed parsing
              .where((article) => article != null)
              .cast<NewsArticle>()
              .toList();
        } catch (e) {
          print('Error processing snapshot: $e');
          // Return empty list on snapshot processing error
          return <NewsArticle>[];
        }
      }).handleError((error) {
        print('Error in stream: $error');
        // Return empty list on stream error
        return <NewsArticle>[];
      });
    } catch (e) {
      print('Error setting up Firebase stream: $e');
      // Return empty stream on setup error
      return Stream.value(<NewsArticle>[]);
    }
  }
}


// models/news_content.dart
// class NewsContent {
//   final String content;
//   final String description;
//   final String title;

//   NewsContent({
//     required this.content,
//     required this.description,
//     required this.title,
//   });

//   factory NewsContent.fromMap(Map<String, dynamic> map) {
//     return NewsContent(
//       content: map['content'] ?? '',
//       description: map['description'] ?? '',
//       title: map['title'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'content': content,
//       'description': description,
//       'title': title,
//     };
//   }
// }

// models/news_article.dart
// import 'package:cloud_firestore/cloud_firestore.dart';

// class NewsArticle {
//   final String id;
//   final NewsContent data;        // English content
//   final NewsContent data_bn;     // Bengali content
//   final String publishDate;
//   final DateTime publishedAt;
//   final String urlToImage;

//   NewsArticle({
//     required this.id,
//     required this.data,
//     required this.data_bn,
//     required this.publishDate,
//     required this.publishedAt,
//     required this.urlToImage,
//   });

//   factory NewsArticle.fromMap(Map<String, dynamic> map, String id) {
//     return NewsArticle(
//       id: id,
//       data: NewsContent.fromMap(map['data'] ?? {}),
//       data_bn: NewsContent.fromMap(map['data_bn'] ?? {}),
//       publishDate: map['publishDate'] ?? '',
//       publishedAt: (map['publishedAt'] as Timestamp).toDate(),
//       urlToImage: map['urlToImage'] ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'data': data.toMap(),
//       'data_bn': data_bn.toMap(),
//       'publishDate': publishDate,
//       'publishedAt': Timestamp.fromDate(publishedAt),
//       'urlToImage': urlToImage,
//     };
//   }

//   // Helper method to get content based on language
//   NewsContent getLocalizedContent(String languageCode) {
//     return languageCode == 'bn' ? data_bn : data;
//   }
// }

// // Example usage in Firebase service
// class FirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final String collectionPath = 'nam5'; // Database location as specified

//   Stream<List<NewsArticle>> getNewsArticles() {
//     return _firestore
//         .collection(collectionPath)
//         .orderBy('publishedAt', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs
//           .map((doc) => NewsArticle.fromMap(doc.data(), doc.id))
//           .toList();
//     });
//   }

//   Future<void> addNewsArticle(NewsArticle article) {
//     return _firestore
//         .collection(collectionPath)
//         .doc()
//         .set(article.toMap());
//   }

//   Future<void> updateNewsArticle(NewsArticle article) {
//     return _firestore
//         .collection(collectionPath)
//         .doc(article.id)
//         .update(article.toMap());
//   }

//   Future<void> deleteNewsArticle(String id) {
//     return _firestore
//         .collection(collectionPath)
//         .doc(id)
//         .delete();
//   }
// }

// Example Controller
// class NewsController extends GetxController {
//   final FirebaseService _firebaseService = FirebaseService();
//   final RxList<NewsArticle> newsArticles = <NewsArticle>[].obs;
//   final RxBool isLoading = true.obs;
//   final RxString currentLanguage = 'en'.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadNewsArticles();
//   }

//   void _loadNewsArticles() {
//     _firebaseService.getNewsArticles().listen(
//       (articles) {
//         newsArticles.value = articles;
//         isLoading.value = false;
//       },
//       onError: (error) {
//         print('Error loading news articles: $error');
//         isLoading.value = false;
//       },
//     );
//   }

//   void toggleLanguage() {
//     currentLanguage.value = currentLanguage.value == 'en' ? 'bn' : 'en';
//   }

//   // Example of how to add a new article
//   Future<void> addArticle(NewsArticle article) async {
//     try {
//       await _firebaseService.addNewsArticle(article);
//     } catch (e) {
//       print('Error adding article: $e');
//       rethrow;
//     }
//   }
// }