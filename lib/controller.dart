import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tripura_news_official_web/service.dart';

import 'model.dart';

class NewsController extends GetxController {
  final remoteConfig = FirebaseRemoteConfig.instance;
  final FirebaseService _firebaseService = FirebaseService();
  // Add RxLists for carousel data
  final RxList<String> imageUrls = <String>[].obs;
  final RxList<String> imageLinks = <String>[].obs;

  final RxList<NewsArticle> newsArticles = <NewsArticle>[].obs;
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _loadNewsArticles();
    initializeRemoteConfig();
  }

  void _loadNewsArticles() {
    _firebaseService.getNewsArticles().listen(
      (articles) {
        newsArticles.value = articles;
        isLoading.value = false;
      },
      onError: (error) {
        if (kDebugMode) {
          print('Error loading news articles: $error');
        }
        isLoading.value = false;
      },
    );
  }

  Future<void> initializeRemoteConfig() async {
    try {
      isLoading(true);

      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));

      await remoteConfig.fetchAndActivate();

      final jsonString = remoteConfig.getString('ads_banner_list');
      if (jsonString.isNotEmpty) {
        final List<dynamic> jsonData = json.decode(jsonString);
        final List<dynamic> items = jsonData;

        // Extract just the URLs and links
        imageUrls.value =
            items.map((item) => item['imageUrl'] as String).toList();

        imageLinks.value = items.map((item) => item['link'] as String).toList();
      }

      errorMessage.value = '';
    } catch (e) {
      print('Error loading remote config: $e');
      errorMessage.value = 'Failed to load carousel data';
    } finally {
      isLoading(false);
    }
  }
}

class CarouselItem {
  final String imageUrl;
  final String link;

  CarouselItem({
    required this.imageUrl,
    required this.link,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      imageUrl: json['imageUrl'] ?? '',
      link: json['link'] ?? '',
    );
  }
}
