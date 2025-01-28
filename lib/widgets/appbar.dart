


import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;

    return AppBar(
      title: Text('Metafic'),
      centerTitle: false,
      backgroundColor: Colors.blue, // Adjust the color as needed
      actions: [
        // Show navigation items in a row for larger screens
        if (!isMobileLayout)
          Row(
            children: [
              _buildNavItem(context, 'Associate'),
              _buildNavItem(context, 'Service'),
              _buildNavItem(context, 'Careers'),
              _buildNavItem(context, 'Blog'),
              _buildNavItem(context, 'Gain Touch'),
            ],
          ),
      ],
      // Show hamburger menu only in mobile layout
      leading: isMobileLayout
          ? IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Open the drawer
                Scaffold.of(context).openDrawer();
              },
            )
          : null, // No leading widget for larger screens
    );
  }

  Widget _buildNavItem(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () {
          // Handle navigation item click
          _handleNavItemClick(context, title);
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
      ),
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