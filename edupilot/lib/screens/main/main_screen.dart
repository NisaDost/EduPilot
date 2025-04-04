import 'package:edupilot/screens/home/home.dart';
import 'package:edupilot/screens/login_register/demo.dart';
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
    Demo(),
    Home(),
  ];

  void _toggleCollapseMenu() {
    setState(() {
      _collapseMenuOpened = !_collapseMenuOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        isMenuOpen: _collapseMenuOpened,
        onMenuToggle: _toggleCollapseMenu,
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
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            left: _collapseMenuOpened ? 0 : -screenWidth * 0.7,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: screenWidth * 0.7,
              child: CollapseMenu(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        selectedIndex: _selectedIndex,
        onTabSelected: (index) {
          setState(() => _selectedIndex = index);
        },
      ),
    );
  }
}