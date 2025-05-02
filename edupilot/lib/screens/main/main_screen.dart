import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/home/home_screen.dart';
import 'package:edupilot/screens/profile/profile_screen.dart';
import 'package:edupilot/screens/quiz/select_lesson_screen.dart';
import 'package:edupilot/screens/quiz/select_quiz_screen.dart';
import 'package:edupilot/screens/store/store_screen.dart';
import 'package:edupilot/services/students_api_handler.dart';
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
  late LessonsByGradeDTO _lessonsByGrade;
  final ValueNotifier<StudentDTO?> _studentNotifier = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _loadStudent();
  }

  Future<void> _loadStudent() async {
    final student = await StudentsApiHandler().getLoggedInStudent();
    _studentNotifier.value = student;
  }

  void _refreshStudent() async {
    final updatedStudent = await StudentsApiHandler().getLoggedInStudent();
    _studentNotifier.value = updatedStudent;
  }

  void _toggleCollapseMenu() {
    setState(() => _collapseMenuOpened = !_collapseMenuOpened);
  }

  void _closeCollapseMenu() {
    if (_collapseMenuOpened) {
      setState(() => _collapseMenuOpened = false);
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

  void _navigateToSelectQuizFromFav(FavoriteLessonDTO lesson) {
    setState(() {
      _screens[6] = SelectQuizScreen(lesson: _lessonsByGrade); // placeholder usage
      _selectedIndex = 6;
    });
  }

  void _navigateToSelectQuiz(LessonsByGradeDTO lesson) {
    setState(() {
      _screens[6] = SelectQuizScreen(lesson: _lessonsByGrade);
      _selectedIndex = 6;
    });
  }

  late final List<Widget> _screens = [
    StoreScreen(),
    const Placeholder(),
    const Placeholder(),
    // These will be rebuilt inside build() using studentNotifier
    const SizedBox(), // Home
    const SizedBox(), // Profile
    SelectLessonScreen(onLessonTap: _navigateToSelectQuiz),
    const Placeholder(), // SelectQuizScreen (dynamic)
  ];

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
            child: ValueListenableBuilder<StudentDTO?>(
              valueListenable: _studentNotifier,
              builder: (context, student, _) {
                if (student == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                _screens[3] = HomeScreen(
                  student: student,
                  onLessonTap: _navigateToSelectQuizFromFav,
                  onRefreshStudent: _refreshStudent,
                );

                _screens[4] = ProfileScreen(
                  onRefreshStudent: _refreshStudent,
                );

                return IndexedStack(
                  index: _selectedIndex,
                  children: _screens,
                );
              },
            ),
          ),

          // Collapse menu overlay
          if (_collapseMenuOpened)
            Positioned(
              left: screenWidth * 0.75,
              top: 0,
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _closeCollapseMenu,
                child: Container(color: Colors.black54),
              ),
            ),

          // Slide-in collapse menu
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
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
