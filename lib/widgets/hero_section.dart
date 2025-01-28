import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'circular_background.dart';
import 'dart:math' as math;

import 'left_side.dart';
import 'middle_hero.dart';

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
      width: screenWidth,
      child: isMobileLayout
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        LeftWidget(),
        MiddleHero(),
        SizedBox(width: 50),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'We\'re Metafic.',
            style: GoogleFonts.poppins(
              fontSize: 40, // Smaller font size for mobile
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'A Technology Services Company',
                textStyle: GoogleFonts.poppins(
                  fontSize: 18, // Smaller font size for mobile
                ),
                speed: Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 1,
            pause: Duration(milliseconds: 500),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              // Add action for the button
            },
            child: Text(
              'Explore Our Work',
              style: GoogleFonts.poppins(
                fontSize: 14, // Smaller font size for mobile
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 10), // Smaller padding for mobile
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
