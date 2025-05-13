import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class AddNewSolvedQuestionScreen extends StatefulWidget {
  const AddNewSolvedQuestionScreen({super.key});

  @override
  State<AddNewSolvedQuestionScreen> createState() => _AddNewSolvedQuestionScreenState();
}

class _AddNewSolvedQuestionScreenState extends State<AddNewSolvedQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    const double topBarHeight = 96;
    return Stack(
      children: 
      [
        Padding(
          padding: const EdgeInsets.only(top: topBarHeight),
          child: Text('data'),
        ),
        Container(
          height: 90,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LargeBodyText('Soru Sayısı Gir', AppColors.successColor),
              const SizedBox(height: 10),
              SmallText('Bugün çözdüğün soruları ekleyelim.', AppColors.titleColor),
            ],
          ),
        ),
      ]
    );
  }
}