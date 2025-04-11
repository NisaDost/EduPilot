import 'package:edupilot/screens/home/home_screen.dart';
import 'package:edupilot/screens/profile/profile_screen.dart';
import 'package:edupilot/shared/custom_app_bar.dart';
import 'package:edupilot/shared/custom_bottom_bar.dart';
import 'package:edupilot/shared/collapse_menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3;
  bool _collapseMenuOpened = false;

  final List<Widget> _screens = const [
    Placeholder(),
    Placeholder(),
    Placeholder(),
    HomeScreen(),
    ProfileScreen(),
  ];

  void _toggleCollapseMenu() {
    setState(() {
      _collapseMenuOpened = !_collapseMenuOpened;
    });
  }

  void _closeCollapseMenu() {
    if (_collapseMenuOpened) {
      setState(() {
        _collapseMenuOpened = false;
      });
    }
  }

  void _navigateToProfile() {
    setState(() => _selectedIndex = 4);
  }

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        isMenuOpen: _collapseMenuOpened,
        onMenuToggle: _toggleCollapseMenu,
        onProfileTap: _navigateToProfile,
      ),
      body: Stack(
        children: [
          // Main screen content
          Positioned.fill(
            child: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),

          // CollapseMenu
          if (_collapseMenuOpened)
            Positioned(
              left: screenWidth * 0.75,
              top: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _closeCollapseMenu,
                child: Container(color: Colors.transparent),
              ),
            ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            left: _collapseMenuOpened ? 0 : -screenWidth * 0.75,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: screenWidth * 0.75,
              child: CollapseMenu(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}