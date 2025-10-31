import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade400, // background color of the bar
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GNav(
            rippleColor: Colors.purple.shade200, // ripple when pressed
            hoverColor: Colors.purple.shade100, // hover color
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.purpleAccent, width: 1),
            tabBorder: Border.all(color: Colors.grey.shade700, width: 1),
            tabShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 8),
            ],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 500),
            gap: 8,
            color: Colors.white70, // unselected icon color
            activeColor: Colors.white, // selected icon & text color
            iconSize: 24,
            tabBackgroundColor: Colors.purple.shade700.withOpacity(
              0.3,
            ), // selected tab background
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            selectedIndex: currentIndex,
            onTabChange: onTap,
            tabs: [
              GButton(icon: LineIcons.home, text: 'Home'),
              GButton(icon: LineIcons.heart, text: 'Likes'),
              GButton(icon: LineIcons.search, text: 'Search'),
              GButton(icon: LineIcons.user, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
