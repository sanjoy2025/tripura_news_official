import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tripura_news_official_web/carousel.dart';
import 'package:tripura_news_official_web/controller.dart';
import 'package:url_strategy/url_strategy.dart';

import 'appDownload.dart';
import 'firebase_options.dart';
import 'rashi_fal_view.dart';
import 'shimmer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    setPathUrlStrategy();
  } catch (e) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tripura News Official - Tripura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0F0F0F),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.pages,
      builder: EasyLoading.init(),
    );
  }
}

// Routes
class AppRoutes {
  static const String home = '/';
  static const String news = '/news';
  static const String sports = '/sports';
  static const String weather = '/weather';

  static final List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => BaseLayout(child: HomePage()),
    ),
    GetPage(
      name: news,
      page: () => const BaseLayout(child: NewsPage()),
    ),
    GetPage(
      name: sports,
      page: () => const BaseLayout(child: SportsPage()),
    ),
    GetPage(
      name: weather,
      page: () => const BaseLayout(child: WeatherPage()),
    ),
  ];
}

// Base Layout Widget (includes AppBar and Footer)
class BaseLayout extends StatelessWidget {
  final Widget child;

  const BaseLayout({super.key, required this.child});
  static const double minContentWidth = 480.0;
  static const double maxContentWidth = 2460.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Expanded(
        child: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: minContentWidth,
                  maxWidth: 1600,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.red,
                      child: const Row(
                        children: [
                          Text(
                            'BREAKING',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    child,
                    // AppDownloadSection(),
                    const CustomFooter(),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Custom AppBar Widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      title: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.home),
        child: Image.asset(
          'images/cropped_tno_new.png',
          height: 60,
          // color: Colors.white,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.home),
          child: Image.asset(
            'images/app-store-tno-2.png',
            height: 45,
            // color: Colors.white,
          ),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.home),
          child: Image.asset(
            'images/playstore-tno.png',
            height: 45,
            // color: Colors.white,
          ),
        ),
        SizedBox(width: 30),
      ],
    );
  }
}

// Custom Category Bar
class CustomCategoryBar extends StatelessWidget {
  const CustomCategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0F0F0F),
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildCategoryTab('Home', AppRoutes.home),
          _buildCategoryTab('News', AppRoutes.news),
          _buildCategoryTab('Sports', AppRoutes.sports),
          _buildCategoryTab('Weather', AppRoutes.weather),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String text, String route) {
    final isSelected = Get.currentRoute == route;
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Bottom Navigation Bar

// Custom Footer Widget
class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF4C4C4C),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'BBC News',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Determine number of columns based on width
                    int crossAxisCount = (constraints.maxWidth / 300).floor();
                    // Ensure at least 1 column and maximum 4 columns
                    crossAxisCount = crossAxisCount.clamp(1, 4);

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 24,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return _buildFooterSection(
                              'Explore the Tripura News Official',
                              [
                                'Home',
                                'News',
                              ],
                            );
                          case 1:
                            return _buildFooterSection(
                              'News Services',
                              [
                                'On your mobile',
                                'Get news alerts',
                                'Contact Tripura News Official News'
                              ],
                            );
                          case 2:
                            return _buildFooterSection(
                              'Terms of Use',
                              [
                                'About the Tripura News Official',
                                'Privacy Policy',
                              ],
                            );
                          case 3:
                            return _buildFooterSection(
                              'Connect with Tripura News Official',
                              [
                                'Facebook',
                              ],
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            color: const Color(0xFF2A2A2A),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    const Text(
                      '© 2024 Tripura News Official. The Tripura News Official is not responsible for the content of external sites.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    _buildFooterLink(
                        'Read about our approach to external linking'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: links.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                links[index],
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLink(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

// Page Widgets
class HomePage extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  if (newsController.isLoading.value) {
                    return const NewsShimmerLoading();
                  }

                  return LayoutBuilder(builder: (context, constraints) {
                    // Calculate number of columns based on width
                    final crossAxisCount = (constraints.maxWidth / 300).floor();
                    return GridView.builder(
                      shrinkWrap: true,
                      primary: true,
                      itemCount: newsController.newsArticles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount > 0 ? crossAxisCount : 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio:
                            1.2, // Adjust this value to control height relative to width
                        mainAxisExtent:
                            null, // Let height be determined by content
                        // mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        final article = newsController.newsArticles[index];
                        return _buildNewsCard(
                            article.data_bn.title,
                            // article.data_bn.content,
                            article.urlToImage,
                            article.publishDate);
                      },
                    );
                  });
                }),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: RashiFal(),
              ),
            )
          ],
        ),

        // Featured Section
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Featured',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Obx(() => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsController.newsArticles.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final article = newsController.newsArticles[index];
                      return _buildFeaturedItem(
                        article.data_bn.title,
                        article.data_bn.description,
                        article.urlToImage,
                      );
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('News Page Content'),
        // Add your news page content here
      ],
    );
  }
}

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Sports Page Content'),
        // Add your sports page content here
      ],
    );
  }
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Weather Page Content'),
        // Add your weather page content here
      ],
    );
  }
}

Widget _buildNewsCard(String title, String imageUrl, String date) {
  return Card(
    elevation: 0,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
          child: imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                )
              : const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.grey),
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Published on $date",
                style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    // fontSize: 16,
                    ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFeaturedItem(String title, String description, String category) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.network(
            category,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TNO Admin",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
