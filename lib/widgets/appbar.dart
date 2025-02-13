import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onItemClick;
  final ScrollController scrollController;

  CustomAppBar({
    required this.onItemClick,
    required this.scrollController,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bool isMobileLayout = MediaQuery.of(context).size.width < 600;

    return AppBar(
      title: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            scrollController.animateTo(
              0,
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          },
          child: Text(
            'Tushar',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      actions: [
        if (!isMobileLayout)
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildNavItem(context, 'About Me'),
                      _buildNavItem(context, 'Technical '),
                      _buildNavItem(context, 'Projects'),
                      _buildNavItem(context, 'Certificates'),
                      _buildNavItem(context, 'Interests'),
                      _buildNavItem(context, 'Education'),
                      _buildNavItem(context, 'Contact'),
                    ],
                  ),
                ),
              ),
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
