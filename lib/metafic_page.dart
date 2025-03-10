import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/custom_cursor.dart';
import 'package:portfolio/widgets/expertise_cursor.dart';
import 'package:url_launcher/url_launcher.dart';

import 'modules/about_me.dart';
import 'modules/certificate_section.dart';
import 'modules/contact_module.dart';
import 'modules/combined_sections.dart';
import 'modules/expertise_section.dart';
import 'modules/interests_section.dart';
import 'modules/projtect_section.dart';
import 'widgets/appbar.dart';
import 'widgets/circular_background.dart';
import 'widgets/hero_section.dart';

class MetaficPage extends StatefulWidget {
  @override
  _MetaficPageState createState() => _MetaficPageState();
}

class _MetaficPageState extends State<MetaficPage> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'About Me': GlobalKey(),
    'Technical ': GlobalKey(),
    'Projects': GlobalKey(),
    'Contact': GlobalKey(),
    'Certificates': GlobalKey(), // Add GlobalKey for Certificates
    'Education': GlobalKey(), // Add GlobalKey for Education
    'Interests': GlobalKey(), // Add GlobalKey for Interests
  };

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;

    return CustomCursor(
      child: Scaffold(
        appBar: CustomAppBar(onItemClick: _scrollToSection, scrollController: _scrollController,),
        drawer: isMobileLayout ? _buildDrawer(context) : null,
        body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            scrollbars: false,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroSection(),
                AboutSection(key: _sectionKeys['About Me']),
                ExpertiseCursor(
                  child: ExpertiseSection(key: _sectionKeys['Technical ']),
                ),
                ProjectsSection(key: _sectionKeys['Projects']),
                CombinedSections(
                  certificatesKey: _sectionKeys['Certificates']!,
                  educationKey: _sectionKeys['Education']!,
                  interestsKey: _sectionKeys['Interests']!,
                ),
                ContactForm(key: _sectionKeys['Contact']),
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
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                _buildDrawerItem(context, 'About Me'),
                _buildDrawerItem(context, 'Technical '),
                _buildDrawerItem(context, 'Projects'),
                _buildDrawerItem(context, 'Certificates'),
                 _buildDrawerItem(context, 'Interests'),
                _buildDrawerItem(context, 'Education'),
               
                _buildDrawerItem(context, 'Contact'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© 2025 Metafic LLC, US. All rights reserved',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        _scrollToSection(title);
        Navigator.pop(context);
      },
    );
  }
}

class ProjectsSectionOne extends StatelessWidget {
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
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
              _buildSocialLinkWithUrl(Icons.link, 'https://github.com/trick4u',
                  'https://github.com/trick4u'),
              _buildSocialLinkWithUrl(
                  Icons.link,
                  'https://dribbble.com/designtranscend',
                  'https://dribbble.com/designtranscend'),
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
          Text(
            'Made with ❤️ Flutter!!',
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
Widget _buildSocialLinkWithUrl(IconData icon, String text, String url) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () => _launchUrl(url),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.blue, size: 16),
          SizedBox(width: 5),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ),
  );
}
}

class ParallaxWidget extends StatelessWidget {
  final Widget child;
  final double offsetFactor;

  ParallaxWidget({required this.child, this.offsetFactor = 0.5});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OverflowBox(
          maxHeight: constraints.maxHeight + 100,
          child: Transform.translate(
            offset: Offset(0, -constraints.maxHeight * offsetFactor),
            child: child,
          ),
        );
      },
    );
  }
}
