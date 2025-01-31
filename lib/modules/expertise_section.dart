import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/widgets/expertise_cursor.dart';

import '../models/expert_model.dart';
import '../widgets/tilt_card.dart';

class ExpertiseSection extends StatefulWidget {
  const ExpertiseSection({Key? key}) : super(key: key);
  @override
  _ExpertiseSectionState createState() => _ExpertiseSectionState();
}

class _ExpertiseSectionState extends State<ExpertiseSection> {
  final List<ExpertiseCard> expertiseCards = [
    ExpertiseCard(
        title: "Core Development",
        subtitle: "FLUTTER, DART & MORE",
        description:
            "Flutter, Dart, Native Android, Cross-Platform Development",
        imageUrl:
            "https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ExpertiseCard(
        title: "State Management",
        subtitle: "ARCHITECTURE & PATTERNS",
        description: "GetX, Provider, Bloc, Riverpod",
        imageUrl:
            "https://images.pexels.com/photos/30359246/pexels-photo-30359246/free-photo-of-mystical-red-light-streak-in-alpine-mountain-landscape.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ExpertiseCard(
        title: "Backend Integration",
        subtitle: "DATABASES & APIS",
        description: "Firebase Suite, RESTful APIs, SQLite, Cloud Firestore",
        imageUrl:
            "https://images.pexels.com/photos/1103969/pexels-photo-1103969.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ExpertiseCard(
        title: "Clean Code",
        subtitle: "PRINCIPLES & PATTERNS",
        description: "MVC, Clean Architecture, SOLID Principles",
        imageUrl:
            "https://images.pexels.com/photos/2370726/pexels-photo-2370726.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ExpertiseCard(
        title: "Quality Assurance",
        subtitle: "TESTING & DEPLOYMENT",
        description: "Unit Testing, Widget Testing, Integration Testing, CI/CD",
        imageUrl:
            "https://images.pexels.com/photos/1144690/pexels-photo-1144690.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ExpertiseCard(
        title: "UI/UX Design",
        subtitle: "FRONTEND EXPERTISE",
        description: "Custom Animations, Material Design, Responsive Layouts",
        imageUrl:
            "https://images.pexels.com/photos/1624496/pexels-photo-1624496.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  ];

  Color _headerColor = Colors.white;
  final Map<int, bool> _hoveredStates = {};

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 3
        : screenWidth > 800
            ? 2
            : 1;

    return MouseRegion(
      cursor: SystemMouseCursors.none,
      child: Container(
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
                  itemBuilder: (context, index) => FadeInUpBig(
                    child: _buildCard(expertiseCards[index], index),
                  ),
                ),
              ],
            ),
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

  Widget _buildCard(ExpertiseCard card, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStates[index] = true),
      onExit: (_) => setState(() => _hoveredStates[index] = false),
      child: TiltCard(
        child: Container(
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF242424),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
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
              Positioned.fill(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _hoveredStates[index] == true ? 0.2 : 0.0,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(card.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
