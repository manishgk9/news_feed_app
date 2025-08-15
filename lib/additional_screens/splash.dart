import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_feed_app/additional_screens/onboarding.dart';
import 'package:news_feed_app/pages/home_page.dart';
import 'package:news_feed_app/utils/contstants/on_boarded.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final onboardingService = OnboardingService();

  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3)); // 3 seconds splash

    if (onboardingService.isOnboarded()) {
      Get.off(() => HomePage());
    } else {
      Get.off(() => const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            // App logo
            SizedBox(height: 10),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "NewsFeed",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Spacer(),
            const CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Developed by Manish',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
