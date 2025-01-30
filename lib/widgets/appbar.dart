import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

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
          Row(
            children: [
              _buildNavItem(context, 'About Me'),
              _buildNavItem(context, 'Technical Skills'),
              _buildNavItem(context, 'Projects'),
              _buildNavItem(context, 'Contact'),
            ],
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: () => onItemClick(title),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}