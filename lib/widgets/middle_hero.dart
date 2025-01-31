import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiddleHero extends StatelessWidget {
  const MiddleHero({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;
    final double titleFontSize = isMobileLayout ? 40 : 60;
    final double subtitleFontSize = isMobileLayout ? 18 : 60;
    final double typewriterFontSize = isMobileLayout ? 18 : 60;

    List<String> animatedTexts = [
      "Experienced",
      "Professional",
      "Flutter Developer",
      "Firebase expert",
      "Creative",
    ];

    return Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I'm ",
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Tushar',
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  TextSpan(
                    text: ".",
                    style: GoogleFonts.poppins(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'A Flutter Developer',
              style: GoogleFonts.poppins(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            Text(
              'Building Cross-Platform',
              style: GoogleFonts.poppins(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            Text(
              'Applications.',
              style: GoogleFonts.poppins(
                fontSize: subtitleFontSize,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: animatedTexts.map((text) {
                return TypewriterAnimatedText(
                  text,
                  textStyle: GoogleFonts.poppins(
                    fontSize: typewriterFontSize,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  cursor: '|',
                );
              }).toList(),
              repeatForever: true,
              pause: Duration(seconds: 2),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
      ),
    );
  }
}
