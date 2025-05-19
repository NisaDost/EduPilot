import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:flutter/material.dart';
import 'package:edupilot/theme.dart';

class IntroSwipeScreen extends StatefulWidget {
  const IntroSwipeScreen({super.key});

  @override
  State<IntroSwipeScreen> createState() => _IntroSwipeScreenState();
}

class _IntroSwipeScreenState extends State<IntroSwipeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  StudentDTO? _student;

  final GlobalKey _bottomContainerKey = GlobalKey();
  // Initialize with a default value to avoid null checks
  double _bottomContainerHeight = 200; // Default height that will be updated

  @override
  void initState() {
    super.initState();
    _loadStudent();
    // Schedule measurement after layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getBottomContainerHeight();
    });
  }

  void _getBottomContainerHeight() {
    final context = _bottomContainerKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      setState(() {
        _bottomContainerHeight = box.size.height;
      });
      debugPrint('Bottom container height: $_bottomContainerHeight');
    } else {
      // If context is not available, try again in the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) => _getBottomContainerHeight());
    }
  }

  Future<void> _loadStudent() async {
    final student = await StudentsApiHandler().getLoggedInStudent();
    setState(() {
      _student = student;
    });
  }

  List<_IntroPageData> _buildPages(StudentDTO student) {
    return [
      _IntroPageData(
        greeting: 'Merhaba, ${student.firstName}!',
        message1: 'Yenilikçi öğrenci başarı takip uygulaması EduPilot\'a hoş geldin.',
        message2: 'Hadi, EduPilot ile neler yapabileceğini keşedelim.',
        asset: 'assets/img/avatar/${student.avatar}'
      ),
      _IntroPageData(
        greeting: 'Soru çözüp puan topla',
        message1: 'Uygulama üzerinden soru çöz ve puan topla.',
        message2: 'Puanlar ile daha sonra dükkandaki ödülleri satın alabilirsin!',
        asset: 'assets/img/intro/quiz_and_coupon.png'
      ),
      _IntroPageData(
        greeting: 'İlerlemeni takip et',
        message1: 'Her gün çözdüğün soru sayısını kaydet, soru sayını gör ve zayıf olduğun konuyu gözden geçir.',
        message2: '',
        asset: 'assets/img/intro/weekly_question.png'
      ),
      _IntroPageData(
        greeting: 'Kendini Dene',
        message1: 'İster ders çalışma teknikleri ister sınav seansları ile kendi çalışma ortamını simüle et.',
        message2: '',
        asset: 'assets/img/intro/simulation.png'
      ),
      _IntroPageData(
        greeting: 'Rozetleri Topla',
        message1: 'Uygulama içerisindeki gizemli görevleri tamamlayarak rozetleri topla ve profilinde sergile.',
        message2: '',
        asset: 'assets/img/intro/achievements.png'
      ),
      _IntroPageData(
        greeting: 'Harika',
        message1: 'Kullanma kılavuzunu tamamladın!',
        message2: 'Hadi, EduPilot ile yolculuğa başla!',
        asset: 'assets/img/mascots/intro_mascot.png'
      ),
    ];
  }

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 144;
    if (_student == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = _buildPages(_student!);

    return Scaffold(
      body: Stack(
        children: [
          // PageView - background content
          Positioned.fill(
            child: Container(
              color: AppColors.primaryAccent,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: pages.length,
                itemBuilder: (context, index) => _buildPage(pages[index], topBarHeight, _bottomContainerHeight),
              ),
            ),
          ),

          // Top logo container - elevated
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: topBarHeight,
              padding: const EdgeInsets.only(top: 48),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset('assets/img/logo/logo_horizontal.png', height: 56),
            ),
          ),

          // Bottom container - elevated
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              key: _bottomContainerKey,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(100),
                    blurRadius: 4,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  XLargeText(pages[_currentPage].greeting, AppColors.secondaryColor, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Text(
                    pages[_currentPage].message1,
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pages[_currentPage].message2,
                    style: TextStyle(fontSize: 16, color: AppColors.textColor),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == index
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: SmallBodyText(
                      _currentPage == (pages.length - 1) 
                      ? 'Tanıtımı bitir' 
                      : 'Tanıtımı atla', 
                      AppColors.primaryAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_IntroPageData data, double topHeight, double bottomHeight) {
    if (data.asset.isEmpty) {
      return Container();
    }
    
    return Container(
      padding: EdgeInsets.only(top: topHeight, bottom: bottomHeight),
      child: Center(
        child: Image.asset(
          data.asset, 
          height: 356,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _IntroPageData {
  final String greeting;
  final String message1;
  final String message2;
  final String asset;

  const _IntroPageData({
    required this.greeting,
    required this.message1,
    required this.message2,
    required this.asset
  });
}