import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project_card.dart';
import '../widgets/tilt_card.dart';

class ProjectsSection extends StatefulWidget {
  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final List<ProjectCard> projectCards = [
    ProjectCard(
      title: "Goalkeep - Planner App",
      description: "A feature-rich planner app for Android and iOS using Flutter and Firebase.",
      imageUrl: "https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      details: [
        "Developing a feature-rich production ready planner app for both android and ios using Flutter and Firebase",
        "Implementing advanced state management using GetX for optimal performance",
        "Integrating robust authentication system with Firebase",
        "Utilizing Cloud Firestore for efficient data management and real-time synchronization",
        "Implementing image compression and Firebase Storage for media management",
        "Developing a custom calendar view with event management capabilities",
        "Creating an intuitive statistics page with interactive graphs and data visualization",
        "Implementing daily notifications to enhance user engagement"
      ]
    ),
    ProjectCard(
      title: "F&O Market Watch",
      description: "A real-time financial module for tracking F&O market data.",
      imageUrl: "https://images.pexels.com/photos/30359246/pexels-photo-30359246/free-photo-of-mystical-red-light-streak-in-alpine-mountain-landscape.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      details: [
        "Led the development of critical financial modules for both mobile and web platforms",
        "Developed F&O Market Watch with real-time data updates and user-friendly interface",
        "Engineered an F&O Contract management system, streamlining operations",
        "Created and launched an IPO module for streamlined application processes",
        "Implemented a secure Wallet Integration system for transaction management",
        "Spearheaded Flutter Web components development",
        "Implemented reusable components for improved efficiency",
        "Utilized GetX for efficient state management"
      ]
    ),
  ];

  final Map<int, bool> _hoveredStates = {};

  void _showProjectDetails(BuildContext context, ProjectCard card) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(
            color: const Color(0xFF242424),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      card.title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Key Features & Achievements:',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...card.details.map((detail) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                detail,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[300],
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200 ? 3 : screenWidth > 800 ? 2 : 1;

    return Container(
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
                itemCount: projectCards.length,
                itemBuilder: (context, index) => _buildCard(projectCards[index], index),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(ProjectCard card, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredStates[index] = true),
      onExit: (_) => setState(() => _hoveredStates[index] = false),
      child: GestureDetector(
        onTap: () => _showProjectDetails(context, card),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey[400],
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Click for details',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[400],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (card.imageUrl != null)
                  Positioned.fill(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: _hoveredStates[index] == true ? 0.2 : 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(card.imageUrl!),
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
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Projects',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}