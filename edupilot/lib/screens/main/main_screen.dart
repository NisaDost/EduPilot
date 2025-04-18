import 'package:edupilot/models/quiz/lesson.dart';
import 'package:edupilot/screens/home/home_screen.dart';
import 'package:edupilot/screens/profile/profile_screen.dart';
import 'package:edupilot/screens/quiz/select_lesson_screen.dart';
import 'package:edupilot/screens/quiz/select_quiz_screen.dart';
import 'package:edupilot/screens/store/store_screen.dart';
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
  //Lesson? _selectedLesson;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      StoreScreen(),
      Placeholder(),
      Placeholder(),
      HomeScreen(onLessonTap: _navigateToSelectQuiz),
      const ProfileScreen(),
      SelectLessonScreen(onLessonTap: _navigateToSelectQuiz), // 5
      const Placeholder(), // temporary, will get replaced with SelectQuizScreen
    ];
  }



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

  void _onTabSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  void _navigateToProfile() {
    setState(() {
      _selectedIndex = 4;
      _collapseMenuOpened = false;
    });
  }

  void _navigateToSelectLesson() {
    setState(() {
      _selectedIndex = 5;
      _collapseMenuOpened = false;
    });
  }

  void _navigateToSelectQuiz(Lesson lesson) {
    setState(() {
      //_selectedLesson = lesson;
      _screens[6] = SelectQuizScreen(lesson: lesson); // replace dynamic screen
      _selectedIndex = 6;
    });
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
                child: Container(color:Colors.black54),
              ),
            ),

          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            left: _collapseMenuOpened ? 0 : -screenWidth * 0.75,
            top: 0,
            bottom: 0,
            child: SizedBox(
              width: screenWidth * 0.75,
              child: CollapseMenu(
                onAllLessonsTap: _navigateToSelectLesson,
                onProfileTap: _navigateToProfile,
              ),
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