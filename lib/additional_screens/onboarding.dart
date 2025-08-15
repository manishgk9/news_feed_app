import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_feed_app/utils/contstants/on_boarded.dart';
import '../pages/home_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Latest News From All Over World",
      "description":
          "Stay ahead with the most recent news from around the globe. "
          "Get real-time updates, breaking news, and top headlines delivered directly to your device. "
          "Whether it's technology, business, sports, or entertainment, stay informed anytime, anywhere.",
      "image": "assets/onboard_1.jpg", // stock image
    },
    {
      "title": "Bookmark Articles By Your Choice",
      "description":
          "Found an article you like? Save it for later! "
          "With our easy-to-use bookmark feature, you can organize your favorite articles and access them even when offline. "
          "Never lose track of important stories or interesting reads.",
      "image": "assets/onboard_2.jpg", // newspaper
    },
    {
      "title": "Stay Updated With Our News App",
      "description":
          "Never miss out on breaking news or trending stories. "
          "Enable notifications to get alerts on the topics you care about most. "
          "Customize your preferences and ensure you stay informed with timely updates, all in one app.",
      "image": "assets/onboard_3.jpg", // computer with articles
    },
  ];
  final onboardingService = OnboardingService();
  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    onboardingService.completeOnboarding();
    Get.off(() => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Full-screen image
                  Image.asset(data["image"]!, fit: BoxFit.cover),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.2),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  // Centered text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data["title"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            data["description"]!,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Bottom dots & buttons
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _finishOnboarding,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Text(
                        _currentPage == onboardingData.length - 1
                            ? "Start"
                            : "Next",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
