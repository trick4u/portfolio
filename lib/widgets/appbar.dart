import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onItemClick;

  CustomAppBar({required this.onItemClick});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;

    return AppBar(
      title: Text('Tushar'),
      centerTitle: false,
      backgroundColor: Colors.white,
      actions: [
        if (!isMobileLayout)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                _buildNavItem(context, 'About Me'),
                _buildNavItem(context, 'Technical '),
                _buildNavItem(context, 'Projects'),
                _buildNavItem(context, 'Contact'),
                _buildNavItem(context, 'Certificates'),
                _buildNavItem(context, 'Education'),
                _buildNavItem(context, 'Interests'),
                _buildNavItem(context, 'Contact'),
              ],
            ),
          ),
      ],
      leading: isMobileLayout
          ? IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            )
          : null,
    );
  }

  Widget _buildNavItem(BuildContext context, String title) {
    bool isHovering = false; // Add this variable to track hover state

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: StatefulBuilder(builder: (context, setState) {
          return InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onHover: (hovering) {
              setState(() {
                isHovering = hovering;
              });
            },
            onTap: () => onItemClick(title),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: isHovering ? Colors.red : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }),
      ),
    );
  }
}
