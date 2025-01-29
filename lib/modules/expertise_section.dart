import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expert_model.dart';
import '../widgets/tilt_card.dart';

class ExpertiseSection extends StatefulWidget {
  @override
  _ExpertiseSectionState createState() => _ExpertiseSectionState();
}

class _ExpertiseSectionState extends State<ExpertiseSection> {
  final List<ExpertiseCard> expertiseCards = [
    ExpertiseCard(
      title: "Core Development",
      subtitle: "FLUTTER, DART & MORE",
      description: "Flutter, Dart, Native Android, Cross-Platform Development",
    ),
    ExpertiseCard(
      title: "State Management",
      subtitle: "ARCHITECTURE & PATTERNS",
      description: "GetX, Provider, Bloc, Riverpod",
    ),
    ExpertiseCard(
      title: "Backend Integration",
      subtitle: "DATABASES & APIS",
      description: "Firebase Suite, RESTful APIs, SQLite, Cloud Firestore",
    ),
    ExpertiseCard(
      title: "Clean Code",
      subtitle: "PRINCIPLES & PATTERNS",
      description: "MVC, Clean Architecture, SOLID Principles",
    ),
    ExpertiseCard(
      title: "Quality Assurance",
      subtitle: "TESTING & DEPLOYMENT",
      description: "Unit Testing, Widget Testing, Integration Testing, CI/CD",
    ),
    ExpertiseCard(
      title: "UI/UX Design",
      subtitle: "FRONTEND EXPERTISE",
      description: "Custom Animations, Material Design, Responsive Layouts",
    ),
  ];

  Color _headerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 3
        : screenWidth > 800
            ? 2
            : 1;

    return Container(
      color: const Color(0xFF1A1A1A),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 40),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.5,
                ),
                itemCount: expertiseCards.length,
                itemBuilder: (context, index) =>
                    _buildCard(expertiseCards[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _headerColor = Colors.red;
        });
      },
      onExit: (_) {
        setState(() {
          _headerColor = Colors.white;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _headerColor,
            ),
            child: Text(
              'Technical Expertise',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(ExpertiseCard card) {
    return TiltCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF242424),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.subtitle,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey[400],
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              card.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}