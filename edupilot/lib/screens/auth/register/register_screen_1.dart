import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/screens/auth/register/register_screen_2.dart';
import 'package:edupilot/screens/auth/register/widgets/fav_lesson_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_info_pop_up.dart';
import 'package:edupilot/screens/auth/register/widgets/register_loadout.dart';
import 'package:edupilot/screens/auth/welcome_screen.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterScreen1 extends StatefulWidget {
  const RegisterScreen1({super.key});

  @override
  State<RegisterScreen1> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  int? _selectedGrade;
  final List<String> _favLessonIds = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LessonsByGradeDTO>>(
      future: LessonsApiHandler().getLessonsByGradeForRegister(_selectedGrade ?? 1),
      builder: (BuildContext context, AsyncSnapshot allLessonsSnapshot) {
        if (allLessonsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final List<LessonsByGradeDTO> allLessons = allLessonsSnapshot.data!;
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 36),
                child: Container(
                  color: AppColors.backgroundAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegisterLoadout(
                        title: '1: Kişisel Bilgiler',
                        infoButtonOnPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => RegisterInfoPopUp(
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InfoRow(text: 'Bu alana kişisel bilgilerinizi giriniz.'),
                                  const SizedBox(height: 8),
                                  InfoRow(
                                    text: 'Sınıfını seçmeden dersleri göremezsin.',
                                  ),
                                  const SizedBox(height: 8),
                                  InfoRow(
                                    text: 'Favori ders seçmek, senin için o derslerin quizlerine hızlı erişim imkanı sağlar.',
                                  ),
                                  const SizedBox(height: 8),
                                  InfoRow(
                                    leading: SmallBodyText('*', AppColors.dangerColor),
                                    text: 'ile işaretli alanların doldurulması zorunludur.',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        pageNumber: 1,
                      ),
                      const SizedBox(height: 16),

                      // Form Section
                      _buildFormFields(),

                      // Ders seçimi
                      _buildContainer([
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabelWithAsterisk('Favori Derslerini Seç:'),
                            const SizedBox(height: 8),
                            SmallBodyText('Seçtiğin dersler hızlı erişimde görüntülenecek', AppColors.titleColor),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: FilledButton(
                            onPressed: () async {
                              if (_selectedGrade == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('"Dersleri Gör" butonunu kullanmadan önce sınıf seçmeniz gerekiyor.'),
                                    showCloseIcon: true,
                                    duration: const Duration(milliseconds: 1750),
                                    backgroundColor: AppColors.dangerColor,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                    ),
                                  ),
                                );
                                return;
                              }
                              final result = await showDialog<Set<String>>(
                                context: context,
                                builder: (context) => FavLessonPopUp(
                                  selectedGrade: _selectedGrade!,
                                  selectedLessons: _favLessonIds,
                                ),
                              );
                              if (result != null) {
                                setState(() {
                                  _favLessonIds.clear();
                                  _favLessonIds.addAll(result);
                                });
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: LargeText('Dersleri Gör', AppColors.backgroundColor),
                          ),
                        ),
                        if (_favLessonIds.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: allLessons.where((lesson) => _favLessonIds.contains(lesson.id)).map((lesson) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SmallBodyText(lesson.name, AppColors.backgroundColor),
                              );
                            }).toList(),
                          ),
                        ],
                      ]
                      ),

                      // Navigation Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 36),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FilledButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primaryAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: XLargeText('Geri', AppColors.backgroundColor),
                            ),
                            FilledButton(
                              onPressed: () {
                                final firstName = _firstNameController.text.trim();
                                final middleName = _middleNameController.text.trim();
                                final lastName = _lastNameController.text.trim();

                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RegisterScreen2(
                                        firstName: firstName,
                                        middleName: middleName,
                                        lastName: lastName,
                                        grade: _selectedGrade!,
                                        favLessonIds: _favLessonIds,
                                      ),
                                    ),
                                  );
                                }
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: XLargeText('İleri', AppColors.backgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormFields() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(children: [
              LargeText('Adın', AppColors.textColor),
              const SizedBox(width: 4),
              LargeText('*', AppColors.dangerColor),
            ]),
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              decoration: _inputDecoration(),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Lütfen isminizi giriniz.' : null,
            ),
            const SizedBox(height: 24),
            Row(children: [LargeText('İkinci Adın', AppColors.textColor)]),
            TextFormField(
              controller: _middleNameController,
              keyboardType: TextInputType.text,
              decoration: _inputDecoration(),
            ),
            const SizedBox(height: 24),
            Row(children: [
              LargeText('Soyadın', AppColors.textColor),
              const SizedBox(width: 4),
              LargeText('*', AppColors.dangerColor),
            ]),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              decoration: _inputDecoration(),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Lütfen soyadınızı giriniz.' : null,
            ),
            const SizedBox(height: 16),
            _buildLabelWithAsterisk('Sınıfın:'),
            DropdownButtonFormField<int>(
              value: _selectedGrade,
              decoration: _inputDecoration(),
              hint: const Text("Sınıf seçiniz"),
              items: List.generate(12, (index) => index + 1)
                  .map((grade) => DropdownMenuItem(
                        value: grade,
                        child: Text('$grade. Sınıf'),
                      ))
                  .toList(),
              validator: (value) => value == null ? 'Lütfen bir sınıf seçiniz.' : null,
              onChanged: (value) => setState(() => _selectedGrade = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabelWithAsterisk(String text) => Row(
        children: [
          LargeText(text, AppColors.textColor),
          const SizedBox(width: 4),
          LargeText('*', AppColors.dangerColor),
        ],
      );

  Widget _buildContainer(List<Widget> children) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(100),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(children: children),
      );

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromRGBO(217, 217, 217, 1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black.withAlpha(64), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.dangerColor, width: 1.5),
      ),
    );
  }
}
