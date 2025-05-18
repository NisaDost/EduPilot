import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/screens/agenda/widgets/agenda_header_responsive.dart';
import 'package:edupilot/services/lessons_api_handler.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddNewSolvedQuestionScreen extends StatefulWidget {
  const AddNewSolvedQuestionScreen({super.key});

  @override
  State<AddNewSolvedQuestionScreen> createState() => _AddNewSolvedQuestionScreenState();
}

class _AddNewSolvedQuestionScreenState extends State<AddNewSolvedQuestionScreen> {
  List<LessonsByGradeDTO> _lessons = [];
  LessonsByGradeDTO? _selectedLesson;
  final TextEditingController _questionCountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLessons();
  }

  Future<void> _loadLessons() async {
    try {
      final lessons = await LessonsApiHandler().getLessonsByGrade();
      setState(() {
        _lessons = lessons;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      locale: const Locale('tr'),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _handleAddButton() async {
    final countText = _questionCountController.text;
    final lesson = _selectedLesson;

    if (lesson == null || countText.isEmpty || int.tryParse(countText) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Lütfen geçerli bir ders ve sayı girin.'),
          backgroundColor: AppColors.dangerColor,
        ),
      );
      return;
    }

    if (_selectedDate.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Gelecek bir tarih seçilemez.'),
          backgroundColor: AppColors.dangerColor,
        ),
      );
      return;
    }

    final count = int.parse(countText);
    final success = await StudentsApiHandler().postSolvedQuestionCountPerLesson(
      count,
      lesson.id,
      _selectedDate,
    );

    final formattedDate = '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '${lesson.name} için $formattedDate tarihinde ekleme başarılı.'
              : 'Soru sayısı eklenemedi.',
        ),
        backgroundColor: success ? AppColors.successColor : AppColors.dangerColor,
      ),
    );

    if (success) {
      _questionCountController.clear();
      setState(() => _selectedLesson = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 104;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 16,
            top: topBarHeight + 16,
            right: 16,
            bottom: 16,
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.backgroundColor,
            ),
            child: _isLoading
                ? Center(
                    child: LoadingAnimationWidget.flickr(
                      leftDotColor: AppColors.primaryColor,
                      rightDotColor: AppColors.secondaryColor,
                      size: 72,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Lesson dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primaryAccent,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<LessonsByGradeDTO>(
                            borderRadius: BorderRadius.circular(10),
                            isExpanded: true,
                            value: _selectedLesson,
                            hint: MediumBodyText("Ders Seçin", AppColors.backgroundColor),
                            dropdownColor: AppColors.primaryAccent,
                            iconEnabledColor: AppColors.backgroundColor,
                            style: TextStyle(color: AppColors.backgroundColor),
                            items: _lessons.map((lesson) {
                              return DropdownMenuItem(
                                value: lesson,
                                child: MediumBodyText(lesson.name, AppColors.backgroundColor),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedLesson = value;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Date Picker
                      ElevatedButton.icon(
                        onPressed: () => _pickDate(context),
                        icon: const Icon(Icons.calendar_today),
                        label: MediumBodyText(
                          'Tarih Seç: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          AppColors.backgroundColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Input + Button Row
                      Row(
                        children: [
                          Expanded(
                            flex: 50,
                            child: TextField(
                              controller: _questionCountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: AppColors.backgroundAccent,
                                labelText: 'Soru Sayısı Gir...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 45,
                            child: ElevatedButton(
                              onPressed: _handleAddButton,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: LargeText('Ekle', AppColors.backgroundColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
        AgendaHeaderResponsive(
          topBarHeight: topBarHeight,
          title: 'Soru Sayısı Gir',
          description: 'Geçmiş veya bugünkü soruları ekleyebilirsin. Gelecek tarihler yasak!',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _questionCountController.dispose();
    super.dispose();
  }
}
