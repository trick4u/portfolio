import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestsSection extends StatefulWidget {
  const InterestsSection({Key? key}) : super(key: key);

  @override
  State<InterestsSection> createState() => _InterestsSectionState();
}

class _InterestsSectionState extends State<InterestsSection> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 800;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        color: _isHovered ? const Color(0xFF1A1A1A) : Colors.white,
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
                      color: _isHovered ? Colors.red : Colors.black,
                    ),
                    child: const Text(
                      'Interests',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Unity Game Development — Spent over 2 years learning Unity game engine during engineering. Familiar with physics objects, inspector tools, and time.deltaTime. Used VS Code as the editor and learned through YouTube channels like Brackeys, Jimmy Vegas, and N3K EN.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: _isHovered ? Colors.white : Colors.black,
                  ),
                  textAlign: isMobile ? TextAlign.center : TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}