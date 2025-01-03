import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppDownloadSection extends StatefulWidget {
  const AppDownloadSection({Key? key}) : super(key: key);

  @override
  State<AppDownloadSection> createState() => _AppDownloadSectionState();
}

class _AppDownloadSectionState extends State<AppDownloadSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isHoveringAppStore = false;
  bool isHoveringPlayStore = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Enhanced responsive breakpoints
        bool isMobile = constraints.maxWidth < 600;
        bool isTablet =
            constraints.maxWidth >= 600 && constraints.maxWidth < 1100;
        bool isDesktop = constraints.maxWidth >= 1100;

        double contentMaxWidth = isDesktop ? 600 : 500;
        double spacing = isMobile
            ? 30
            : isTablet
                ? 40
                : 60;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile
                ? 20
                : isTablet
                    ? 40
                    : 60,
            vertical: isMobile
                ? 60
                : isTablet
                    ? 80
                    : 100,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3A8A),
                Color(0xFF2563EB),
                Color(0xFF3B82F6),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Column(
            children: [
              // Floating shapes background
              if (!isMobile) _buildFloatingShapes(),

              // Main content
              Wrap(
                alignment: WrapAlignment.center,
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  // Left Section - Content
                  Container(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: Column(
                      crossAxisAlignment: isMobile
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: [
                        // Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '⭐ 4.9 Rating on App Store',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),

                        // Main heading with gradient text
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.white,
                              Colors.white.withOpacity(0.9)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Experience The Next\nGeneration App',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? 32
                                  : isTablet
                                      ? 40
                                      : 48,
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign:
                                isMobile ? TextAlign.center : TextAlign.left,
                          ),
                        ),
                        SizedBox(height: spacing * 0.5),

                        // Description
                        Text(
                          'Transform your mobile experience with our cutting-edge app. '
                          'Enjoy seamless performance, beautiful design, and powerful features '
                          'that make your life easier.',
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.6,
                          ),
                          textAlign:
                              isMobile ? TextAlign.center : TextAlign.left,
                        ),
                        SizedBox(height: spacing),

                        // Download stats
                        if (!isMobile) _buildStats(),
                        if (!isMobile) SizedBox(height: spacing),

                        // Download Buttons
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          alignment: isMobile
                              ? WrapAlignment.center
                              : WrapAlignment.start,
                          children: [
                            _buildStoreButton(
                              icon: Icons.apple,
                              storeName: 'App Store',
                              isHovering: isHoveringAppStore,
                              onHover: (value) {
                                setState(() => isHoveringAppStore = value);
                              },
                            ),
                            _buildStoreButton(
                              icon: Icons.android,
                              storeName: 'Google Play',
                              isHovering: isHoveringPlayStore,
                              onHover: (value) {
                                setState(() => isHoveringPlayStore = value);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right Section - App Preview
                  if (!isMobile) ...[
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: isDesktop ? 500 : 400,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Animated background shapes
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _controller.value * 2 * math.pi,
                                child: Container(
                                  height: isDesktop ? 600 : 500,
                                  width: isDesktop ? 400 : 300,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.withOpacity(0.2),
                                        Colors.purple.withOpacity(0.1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              );
                            },
                          ),

                          // App screenshots carousel
                          Container(
                            height: isDesktop ? 580 : 480,
                            width: isDesktop ? 380 : 280,
                            child: PageView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 30,
                                        offset: Offset(0, 15),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/app_preview_${index + 1}.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildStatItem('1M+', 'Downloads'),
        SizedBox(width: 40),
        _buildStatItem('4.9', 'Rating'),
        SizedBox(width: 40),
        _buildStatItem('50K+', 'Reviews'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreButton({
    required IconData icon,
    required String storeName,
    required bool isHovering,
    required ValueChanged<bool> onHover,
  }) {
    return MouseRegion(
      onEnter: (_) => onHover(true),
      onExit: (_) => onHover(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: isHovering ? Colors.white : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (isHovering)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: Colors.black87,
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Download on',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  storeName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingShapes() {
    return Positioned.fill(
      child: Stack(
        children: List.generate(
          5,
          (index) => AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final position = index * (2 * math.pi / 5);
              final offset = 100.0;
              return Positioned(
                left: math.cos(position + _controller.value * 2 * math.pi) *
                        offset +
                    offset,
                top: math.sin(position + _controller.value * 2 * math.pi) *
                        offset +
                    offset,
                child: Transform.rotate(
                  angle: position,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
