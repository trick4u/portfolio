import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CombinedSections extends StatefulWidget {
  final GlobalKey certificatesKey;
  final GlobalKey educationKey;
  final GlobalKey interestsKey;

  const CombinedSections({
    Key? key,
    required this.certificatesKey,
    required this.educationKey,
    required this.interestsKey,
  }) : super(key: key);

  @override
  State<CombinedSections> createState() => _CombinedSectionsState();
}

class _CombinedSectionsState extends State<CombinedSections> {
  bool _isHovered = false;
  bool _isHoveredCertificates = false;
  bool _isHoveredEducation = false;
  bool _isHoveredInterests = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 800;
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: Column(
        children: [
          Container(
            key: widget.certificatesKey,
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
                          'Certificates', // Keep your original title
                          textAlign: TextAlign.left, // Add this
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Flutter Create :Developed an innovative Flutter app under 5KB, showcasing exceptional code optimization skills. The app was a simple list scroll view that had images scrolling vertically, the goal was to keep the app under 5KB, and it was a great learning experience.",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: _isHovered ? Colors.white : Colors.black,
                      ),
                      textAlign: isMobile ? TextAlign.left : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //interests

          Container(
            key: widget.interestsKey,
            color: _isHoveredInterests ? const Color(0xFF1A1A1A) : Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MouseRegion(
                      onEnter: (_) =>
                          setState(() => _isHoveredInterests = true),
                      onExit: (_) =>
                          setState(() => _isHoveredInterests = false),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color:
                              _isHoveredInterests ? Colors.red : Colors.black,
                        ),
                        child: const Text(
                          'Interests', // Keep your original title
                          textAlign: TextAlign.left, // Add this
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Unity Game Development — Spent over 2 years learning Unity game engine during engineering. Familiar with physics objects, inspector tools, and time.deltaTime. Used VS Code as the editor and learned through YouTube channels like Brackeys, Jimmy Vegas, and N3K EN.",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color:
                            _isHoveredInterests ? Colors.white : Colors.black,
                      ),
                      textAlign: isMobile ? TextAlign.left : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //education

          Container(
            key: widget.educationKey,
            color: _isHoveredEducation ? const Color(0xFF1A1A1A) : Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MouseRegion(
                      onEnter: (_) =>
                          setState(() => _isHoveredEducation = true),
                      onExit: (_) =>
                          setState(() => _isHoveredEducation = false),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color:
                              _isHoveredEducation ? Colors.red : Colors.black,
                        ),
                        child: const Text(
                          'Education', // Keep your original title
                          textAlign: TextAlign.left, // Add this
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "June 2014 – July 2018 Bharti Vidyapeeth College of Engineering, B.Tech Production Pune, India. Pursued a Bachelor of Technology in Production Engineering. Completed the course with a CGPA of 7.5.",
                      textDirection: TextDirection.ltr,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color:
                            _isHoveredEducation ? Colors.white : Colors.black,
                      ),
                      textAlign: isMobile ? TextAlign.left : TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
