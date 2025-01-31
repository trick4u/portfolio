import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CertificatesSection extends StatefulWidget {
  const CertificatesSection({Key? key}) : super(key: key);

  @override
  State<CertificatesSection> createState() => _CertificatesSectionState();
}

class _CertificatesSectionState extends State<CertificatesSection> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust layout based on screen width
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 800 && screenWidth <= 1200;
    final isMobile = screenWidth <= 800;

    return MouseRegion(
      onEnter: (_) =>
          setState(() => _isHovered = true), // Set hover state to true
      onExit: (_) => setState(() => _isHovered = false),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: Container(
          color: _isHovered ? const Color(0xFF1A1A1A) : Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                      color: _isHovered ? Colors.red : Colors.black,
                    ),
                    child: const Text(
                      'Certificates', // Keep your original title
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "Flutter Create \n Developed an innovative Flutter app under 5KB, showcasing exceptional code optimization skills.",
                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: _isHovered ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
