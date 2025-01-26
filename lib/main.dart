import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_cursor.dart';
import 'metafic_page.dart';

void main() {
runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tushar Sekkaranantri - Portfolio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: MetaficPage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomCursor(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(),
              ProfileSection(),
              TechnicalExpertiseSection(),
              ProfessionalExperienceSection(),
              EducationSection(),
              CertificatesSection(),
              ProjectsSection(),
              InterestsSection(),
              FooterSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.indigo],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Tushar Sekkaranantri',
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Senior Flutter Developer',
            style: GoogleFonts.poppins(
              fontSize: 24,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            spacing: 20,
            children: [
              _buildContactItem(Icons.email, 'thinkbrain10@gmail.com'),
              _buildContactItem(Icons.phone, '+91 9975768621'),
              _buildContactItem(
                  Icons.location_on, 'Bhopal, Madhya Pradesh, India'),
              _buildContactItem(Icons.link, 'github.com/irick4u'),
              _buildContactItem(Icons.link, 'dribbble.com/designtranscend'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 16),
        SizedBox(width: 5),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class ProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PROFILE',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Senior Flutter Developer with 5+ years of expertise since Flutter’s initial stable release. Proven track record in architecting and delivering high-performance, scalable mobile and web applications. Specialized in advanced state management, complex API integrations, and Firebase implementations. Distinguished for creating battery-efficient applications with comprehensive testing coverage and exceptional user experiences.',
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

class TechnicalExpertiseSection extends StatelessWidget {
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
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TECHNICAL EXPERTISE',
            style: GoogleFonts.poppins(
              fontSize: 24,
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

class ProfessionalExperienceSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PROFESSIONAL EXPERIENCE',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildExperienceItem(
            'June 2022 – October 2024',
            'VenturaSecurities, Assistant Manager Flutter',
            'Thane, India',
            '''
            - Led the development of critical financial modules for both mobile and web platforms, significantly enhancing the company’s digital offerings.
            - Developed F&O Market Watch with real-time data updates and a user-friendly interface.
            - Engineered an F&O Contract management system, streamlining operations.
            - Created and launched an IPO module for streamlined application processes.
            - Implemented a secure Wallet Integration system for transaction management.
            - Spearheaded the development of Flutter Web components, ensuring cross-platform consistency.
            - Collaborated effectively within a team, fostering a culture of code quality and best practices.
            - Implemented reusable components, improving development efficiency and maintainability.
            - Utilized GetX for efficient state management across applications.
            ''',
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(
      String date, String title, String location, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          location,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
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
        SizedBox(height: 20),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: Colors.grey[200],
      child: Center(
        child: Text(
          '© 2024 Tushar Sekkaranantri. All rights reserved.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PROJECTS',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildProjectItem(
            'September 2024 – November 2024',
            'Goalkeep - Planner App',
            '''
            - Developing a feature-rich production-ready planner app for both Android and iOS using Flutter and Firebase.
            - Implementing advanced state management using GetX for optimal performance.
            - Integrating a robust authentication system with Firebase.
            - Utilizing Cloud Firestore for efficient data management and real-time synchronization.
            - Implementing image compression and Firebase Storage for media management.
            - Developing a custom calendar view with event management capabilities.
            - Creating an intuitive statistics page with interactive graphs and data visualization.
            - Implementing daily notifications to enhance user engagement.
            ''',
          ),
        ],
      ),
    );
  }

  Widget _buildProjectItem(String date, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
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
        SizedBox(height: 20),
      ],
    );
  }
}

class CertificatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CERTIFICATES',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildCertificateItem(
            'Flutter Create (2)',
            'Developed an innovative Flutter app under EKB, showcasing exceptional code optimization skills.',
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateItem(String title, String description) {
    return Column(
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
        SizedBox(height: 20),
      ],
    );
  }
}

class EducationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EDUCATION',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildEducationItem(
            'June 2014 – July 2018',
            'Bharti Vidyapeeth College of Engineering',
            'B.Tech in Production Engineering',
            'Pune, India',
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(
      String date, String institution, String degree, String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        Text(
          institution,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          degree,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Text(
          location,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class InterestsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INTERESTS',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '''
            - Unity Game Development: Spent more than 2 years learning Unity game engine during engineering.
            - Used VS Code as the editor and learned game development through YouTube tutorials (Brackeys, Jimmy Vegas, N3K EN, etc.).
            - Familiar with physics objects, inspector tools, and time.deltaTime.
            ''',
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
