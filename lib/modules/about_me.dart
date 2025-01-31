import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust layout based on screen width
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 800 && screenWidth <= 1200;
    final isMobile = screenWidth <= 800;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _isHovered
                        ? Colors.red
                        : Colors
                            .black, // You can add hover color logic if needed
                  ),
                  child: const Text(
                    'About Me',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Senior Flutter Developer with 5+ years of expertise since Flutter's initial stable release. Proven track  record in architecting and delivering high-performance, scalable mobile and web applications. Specialized in advanced state management, complex API integrations, and Firebase implementations. Distinguished for creating battery-efficient applications with comprehensive testing coverage and exceptional user experiences.",
                textDirection: TextDirection.ltr,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
