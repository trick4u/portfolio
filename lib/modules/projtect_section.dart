import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project_card.dart';
import '../widgets/tilt_card.dart';

class ProjectsSection extends StatefulWidget {
   const ProjectsSection({Key? key}) : super(key: key);
  
  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  final List<ProjectCard> projectCards = [
    ProjectCard(
        title: "Goalkeep - Planner App",
        description:
            "A feature-rich planner app for Android and iOS using Flutter and Firebase.",
        imageUrl:
            "https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        details: [
          "Developing a feature-rich production ready planner app for both android and ios using Flutter and Firebase",
          "Implementing advanced state management using GetX for optimal performance",
          "Integrating robust authentication system with Firebase",
          "Utilizing Cloud Firestore for efficient data management and real-time synchronization",
          "Implementing image compression and Firebase Storage for media management",
          "Developing a custom calendar view with event management capabilities",
          "Creating an intuitive statistics page with interactive graphs and data visualization",
          "Implementing daily notifications to enhance user engagement"
        ]),
    ProjectCard(
        title: "F&O Market Watch",
        description:
            "A real-time financial module for tracking F&O market data.",
        imageUrl:
            "https://images.pexels.com/photos/30359246/pexels-photo-30359246/free-photo-of-mystical-red-light-streak-in-alpine-mountain-landscape.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        details: [
          "Led the development of critical financial modules for both mobile and web platforms",
          "Developed F&O Market Watch with real-time data updates and user-friendly interface",
          "Engineered an F&O Contract management system, streamlining operations",
          "Created and launched an IPO module for streamlined application processes",
          "Implemented a secure Wallet Integration system for transaction management",
          "Spearheaded Flutter Web components development",
          "Implemented reusable components for improved efficiency",
          "Utilized GetX for efficient state management"
        ]),
  ];

  final Map<int, bool> _hoveredStates = {};
  Color _headerColor = Colors.black;
  int _selectedProjectIndex = 0;
  Color _textColor = Colors.white;

  @override
  void initState() {
    super.initState();
    // Set first project as default
    _selectedProjectIndex = 0;
  }

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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
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
                      ...card.details
                          .map((detail) => Padding(
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
                              ))
                          .toList(),
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

    // Adjust layout based on screen width
    final isDesktop = screenWidth > 1200;
    final isTablet = screenWidth > 800 && screenWidth <= 1200;
    final isMobile = screenWidth <= 800;

    // Adjust grid columns based on screen size
    final crossAxisCount = isDesktop ? 2 : 1;

    // For tablet and mobile, use column layout instead of row
    if (isTablet || isMobile) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                // Project highlights container for tablet

                if (isTablet)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 40),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _buildHighlightsContent(),
                    ),
                  ),
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
                  itemBuilder: (context, index) => FadeInUpBig(
                      child: _buildCard(projectCards[index], index)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Desktop layout
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side with header and grid
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      itemBuilder: (context, index) => FadeInUpBig(
                          child: _buildCard(projectCards[index], index)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 40),
              // Right side container (Project Highlights)
              Expanded(
                flex: 1,
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFF1A1A1A),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _buildHighlightsContent(),
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

  Widget _buildHighlightsContent() {
    final selectedProject = projectCards[_selectedProjectIndex];
    return MouseRegion(
      onEnter: (_) => setState(() => _textColor = Colors.red),
      onExit: (_) => setState(() => _textColor = Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _textColor,
            ),
            child: Text(selectedProject.title),
          ),
          const SizedBox(height: 16),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: _textColor.withOpacity(0.8),
              height: 1.6,
            ),
            child: Text(selectedProject.description),
          ),
          const SizedBox(height: 24),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _textColor.withOpacity(0.7),
            ),
            child: const Text('Key Features:'),
          ),
          const SizedBox(height: 12),
          ...selectedProject.details
              .map((detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _textColor.withOpacity(0.7),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: _textColor.withOpacity(0.7),
                              height: 1.5,
                            ),
                            child: Text(detail),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCard(ProjectCard card, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _hoveredStates[index] = true;
        _selectedProjectIndex = index; // Update selected project on hover
      }),
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
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _hoveredStates[index] == true
                              ? Colors.red
                              : Colors.white,
                        ),
                        child: Text(card.title),
                      ),
                      const SizedBox(height: 12),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: _hoveredStates[index] == true
                              ? Colors.red.withOpacity(0.7)
                              : Colors.grey[300],
                        ),
                        child: Text(card.description),
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
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _headerColor = Colors.red;
        });
      },
      onExit: (_) {
        setState(() {
          _headerColor = Colors.black;
        });
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: _headerColor,
        ),
        child: Text(
          textAlign: TextAlign.left,
          'Projects',
        ),
      ),
    );
  }
}
