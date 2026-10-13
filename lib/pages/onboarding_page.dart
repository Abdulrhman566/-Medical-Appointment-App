import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:session_26_9/core/app_constants/app_colors.dart';
import 'package:session_26_9/pages/choice_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // ================= COLORS =================

  static final Color primaryColor = AppColors.primary;
  static const Color titleColor = Color(0xFF173B66);
  static const Color subtitleColor = Color(0xFF7A8594);
  static const Color lightBlue = Color(0xFFEAF3FF);

  // ================= NAVIGATION =================

  void finishOnboarding() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ChoicePage(),
        transitionDuration: const Duration(milliseconds: 550),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  // ================= IMAGE WIDGET =================

  Widget buildImage(String image) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: primaryColor.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.10),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          image,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Icon(
                Icons.medical_services_outlined,
                color: primaryColor,
                size: 65,
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= PAGE BUILDER =================

  PageViewModel buildPage({
    required String title,
    required String description,
    required String image,
  }) {
    return PageViewModel(
      title: title,
      body: description,
      image: buildImage(image),
      decoration: const PageDecoration(
        pageColor: Colors.white,

        // Title Style
        titleTextStyle: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
          color: titleColor,
          letterSpacing: -0.5,
        ),

        // Description Style
        bodyTextStyle: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: subtitleColor,
          fontWeight: FontWeight.w400,
        ),

        titlePadding: EdgeInsets.only(top: 30, bottom: 14),

        bodyPadding: EdgeInsets.symmetric(horizontal: 28),

        imagePadding: EdgeInsets.only(top: 30, left: 10, right: 10),

        imageFlex: 3,
        bodyFlex: 2,
      ),
    );
  }

  // ================= NEXT BUTTON =================

  Widget buildNextButton() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Icon(
        Icons.arrow_forward_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }

  // ================= DONE BUTTON =================

  Widget buildDoneButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Text(
        'Get Started',
        style: TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: Colors.white,

          // ================= PAGES =================
          pages: [
            buildPage(
              title: 'Find Your Doctor',
              description: 'Discover experienced doctors and find the right specialist for your healthcare needs.',
              image: 'assets/images/national-cancer-institute-L8tWZT4CcVQ-unsplash.jpg',
            ),

            buildPage(
              title: 'Book Appointments Easily',
              description: 'Schedule your appointments anytime, anywhere with just a few simple taps.',
              image: 'assets/images/anton-8q-U8X1zkvI-unsplash.jpg',
            ),

            buildPage(
              title: 'Your Health, Our Priority',
              description: 'Manage your healthcare journey and stay connected with your doctors, all in one place.',
              image: 'assets/images/national-cancer-institute-NFvdKIhxYlU-unsplash.jpg',
            ),
          ],

          // ================= SKIP BUTTON =================
          showSkipButton: true,

          skip: const Text(
            'Skip',
            style: TextStyle(
              color: subtitleColor,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          // ================= NEXT BUTTON =================
          next: buildNextButton(),

          // ================= DONE BUTTON =================
          done: buildDoneButton(),

          onDone: finishOnboarding,
          onSkip: finishOnboarding,

          // ================= DOT INDICATORS =================
          dotsDecorator: DotsDecorator(
            size: const Size(8, 8),
            activeSize: const Size(28, 8),
            color: Colors.grey.shade300,
            activeColor: primaryColor,
            spacing: const EdgeInsets.symmetric(horizontal: 4),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // ================= ANIMATION =================
          curve: Curves.easeInOutCubic,

          animationDuration: 450,

          controlsPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),

          controlsMargin: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
