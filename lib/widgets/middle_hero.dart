import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiddleHero extends StatelessWidget {
  const MiddleHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Adjust font sizes based on screen width
    final double titleFontSize = isMobileLayout ? 40 : 64;
    final double subtitleFontSize = isMobileLayout ? 18 : 24;
    final double buttonFontSize = isMobileLayout ? 14 : 16;

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ensure "We're Metafic." stays in a single line
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'We\'re Metafic.',
                style: GoogleFonts.poppins(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1, // Ensure text stays in one line
                overflow:
                    TextOverflow.ellipsis, // Add ellipsis if text overflows
              ),
            ),
            SizedBox(height: 20),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'A Technology Services Company',
                  textStyle: GoogleFonts.poppins(
                    fontSize: subtitleFontSize,
                  ),
                  speed: Duration(milliseconds: 100),
                  cursor: "|",
                ),
              ],
              totalRepeatCount: 10,
              pause: Duration(seconds: 2),
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
                  fontSize: buttonFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobileLayout ? 20 : 30,
                  vertical: isMobileLayout ? 10 : 15,
                ),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
