import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/agenda/add_new_solved_question_screen.dart';
import 'package:edupilot/screens/agenda/agenda_screen.dart';
import 'package:edupilot/screens/agenda/daily_details_screen.dart';
import 'package:edupilot/screens/analysys/quiz_analysys_screen.dart';
import 'package:edupilot/screens/home/home_screen.dart';
import 'package:edupilot/screens/profile/profile_screen.dart';
import 'package:edupilot/screens/sellector/select_lesson_screen.dart';
import 'package:edupilot/screens/sellector/select_quiz_screen.dart';
import 'package:edupilot/screens/simulation/simulation_screen.dart';
import 'package:edupilot/screens/store/store_screen.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/custom_app_bar.dart';
import 'package:edupilot/shared/custom_bottom_bar.dart';
import 'package:edupilot/shared/collapse_menu.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3;
  bool _collapseMenuOpened = false;
  final ValueNotifier<StudentDTO?> _studentNotifier = ValueNotifier(null);
  
  // Navigation history stack to track screen changes
  final List<int> _navigationHistory = [3]; // Start with home screen index

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
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _navigationHistory.add(index);
      });
    }
  }

  // Method to handle back button press
  Future<bool> _onWillPop() async {
    // Handle first closing the menu if it's open
    if (_collapseMenuOpened) {
      _closeCollapseMenu();
      return false; // Prevent app exit
    }
    
    // If we have navigation history and not on the first screen
    if (_navigationHistory.length > 1) {
      _navigationHistory.removeLast(); // Remove current screen
      setState(() {
        _selectedIndex = _navigationHistory.last; // Go to previous screen
      });
      return false; // Prevent app exit
    }
    
    // Show exit confirmation dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: LargeText('Gidiyor musun? :(', AppColors.secondaryColor, textAlign: TextAlign.center),
        content: MediumText('Çıkış yapmak istediğinden emin misin?', AppColors.textColor),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: MediumText('Hayır', AppColors.dangerColor),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: MediumText('Evet', AppColors.successColor),
          ),
        ],
      ),
    ) ?? false;
    
    if (shouldExit) {
      // This will close the app
      SystemNavigator.pop();
    }
    
    return false; // Always return false to handle exit manually
  }

  void _navigateToProfile() {
    setState(() {
      _selectedIndex = 4;
      _navigationHistory.add(4);
      _collapseMenuOpened = false;
    });
  }

  void _navigateToSelectLesson() {
    setState(() {
      _selectedIndex = 5;
      _navigationHistory.add(5);
      _collapseMenuOpened = false;
    });
  }

  void _navigateToSelectQuizFromFav(FavoriteLessonDTO lesson) {
    setState(() {
      _screens[6] = SelectQuizScreen(lesson: LessonsByGradeDTO.fromFavoriteLessonDTO(lesson));
      _selectedIndex = 6;
      _navigationHistory.add(6);
    });
  }

  void _navigateToSelectQuiz(LessonsByGradeDTO lesson) {
    setState(() {
      _screens[6] = SelectQuizScreen(lesson: lesson);
      _selectedIndex = 6;
      _navigationHistory.add(6);
    });
  }

  void _navigateToAddNewSolvedQuestion() {
    setState(() {
      _screens[7] = AddNewSolvedQuestionScreen();
      _selectedIndex = 7;
      _navigationHistory.add(7);
    });
  }

  void _navigateToDailyAnalysys(date) {
    setState(() {
      _screens[8] = DailyDetailsScreen(date: date);
      _selectedIndex = 8;
      _navigationHistory.add(8);
    });
  }

  void _navigateToQuizAnalysys() {
    setState(() {
      _screens[9] = QuizAnalysysScreen();
      _selectedIndex = 9;
      _navigationHistory.add(9);
      _collapseMenuOpened = false;
    });
  }

  late final List<Widget> _screens = [
    const SizedBox(), // StoreScreen (dynamic)
    const SizedBox(), // AgendaScreen (dynamic)
    const SizedBox(), // SimulationScreen (dynamic)
    // These will be rebuilt inside build() using studentNotifier
    const SizedBox(), // Home
    const SizedBox(), // Profile
    SelectLessonScreen(onLessonTap: _navigateToSelectQuiz),
    const Placeholder(), // SelectQuizScreen (dynamic)
    const Placeholder(), // AddNewSolvedQuestionScreen (dynamic)
    const Placeholder(), // DailyDetailsScreen (dynamic)
    const Placeholder(), // QuizAnalysysScreen (dynamic)
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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
                    return Center(child: LoadingAnimationWidget.flickr(
                      leftDotColor: AppColors.primaryColor,
                      rightDotColor: AppColors.secondaryColor,
                      size: 72,
                      ));
                  }
                  _screens[0] = StoreScreen(
                    onRefreshStudent: _refreshStudent,
                  );
      
                  _screens[1] = AgendaScreen(
                    onNavigateToAddQuestion: _navigateToAddNewSolvedQuestion,
                    onNavigateToDailyAnalysys: (date) => _navigateToDailyAnalysys(date),
                  );
      
                  _screens[2] = const SimulationScreen();
      
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
                  onQuizAnalysysTap: _navigateToQuizAnalysys,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomBar(
          selectedIndex: _selectedIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
    );
  }
}