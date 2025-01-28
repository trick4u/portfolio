import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/custom_cursor.dart';

import 'modules/contact_module.dart';
import 'widgets/appbar.dart';

class MetaficPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;
    return CustomCursor(
      child: Scaffold(
        appBar: CustomAppBar(),
        drawer: isMobileLayout ? _buildDrawer(context) : null,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false, // Hide scrollbars
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeroSection(),
                AboutSection(),
                ExpertiseSection(),
                ProjectsSection(),
                ContactForm(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Adjust the color as needed
            ),
            child: Text(
              'Metafic',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(context, 'Associate'),
          _buildDrawerItem(context, 'Service'),
          _buildDrawerItem(context, 'Careers'),
          _buildDrawerItem(context, 'Blog'),
          _buildDrawerItem(context, 'Gain Touch'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        // Handle drawer item click
        _handleNavItemClick(context, title);
        // Close the drawer
        Navigator.pop(context);
      },
    );
  }

  void _handleNavItemClick(BuildContext context, String title) {
    // Handle navigation item click
    // For example, you can navigate to different pages or show a dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title clicked')),
    );
  }
}

class HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height, // Full-screen height
      width: MediaQuery.of(context).size.width, // Full-screen width
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'We\'re Metafic.',
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'A Technology Services Company',
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Add action for the button
              },
              child: Text(
                'Explore Our Work',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                backgroundColor: Colors.orange,
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

class AboutSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'About Me',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Senior Flutter Developer with 5+ years of expertise since Flutter’s initial stable release. Proven track record in architecting and delivering high-performance, scalable mobile and web applications. Specialized in advanced state management, complex API integrations, and Firebase implementations.',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ExpertiseSection extends StatelessWidget {
  final List<String> skills = [
    'Flutter, Dart, Native Android, Cross-Platform Development',
    'GetX, Provider, Bloc, Riverpod',
    'Firebase Suite, RESTful APIs, SQLite, Cloud Firestore',
    'MVC, Clean Architecture, SOLID Principles',
    'Unit Testing, Widget Testing, Integration Testing, CI/CD',
    'Custom Animations, Material Design, Responsive Layouts',
    'Git, Android Studio, VS Code, Firebase Console, Jira',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Technical Expertise',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills.map((skill) => Chip(label: Text(skill))).toList(),
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Projects',
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildProjectItem(
            'Goalkeep - Planner App',
            'A feature-rich planner app for Android and iOS using Flutter and Firebase.',
          ),
          _buildProjectItem(
            'F&O Market Watch',
            'A real-time financial module for tracking F&O market data.',
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey[200],
      child: Column(
        children: [
          Text(
            'Connect with Me',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: [
              _buildSocialLink(Icons.email, 'thinkbrain10@gmail.com'),
              _buildSocialLink(Icons.phone, '+91 9975768621'),
              _buildSocialLink(Icons.link, 'github.com/irick4u'),
              _buildSocialLink(Icons.link, 'dribbble.com/designtranscend'),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '© 2024 Tushar Sekkaranantri. All rights reserved.',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialLink(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey[700], size: 16),
        SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
