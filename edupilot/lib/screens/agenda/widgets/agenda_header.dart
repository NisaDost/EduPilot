import 'package:edupilot/models/dtos/student_dto.dart';
import 'package:edupilot/screens/profile/widgets/supervisors_list_pop_up.dart';
import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AgendaHeader extends StatelessWidget {
  final Future<StudentDTO> studentFuture;

  const AgendaHeader({super.key, required this.studentFuture});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LargeBodyText('Ajanda', AppColors.successColor),
              FutureBuilder<StudentDTO>(
                future: studentFuture,
                builder: (context, studentSnapshot) {
                  if (studentSnapshot.connectionState == ConnectionState.waiting) {
                    return LoadingAnimationWidget.flickr(
                      leftDotColor: AppColors.primaryColor,
                      rightDotColor: AppColors.secondaryColor,
                      size: 48,
                    );
                  } else if (studentSnapshot.hasError || !studentSnapshot.hasData) {
                    return const Text('Danışman bulunamadı');
                  }

                  final student = studentSnapshot.data!;
                  return AgendaScreenButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => SupervisorsListPopUp(
                          supervisorsList: student.studentSupervisors
                                  ?.map((s) => s.supervisorName)
                                  .toList() ??
                              [],
                        ),
                      );
                    },
                    color: AppColors.secondaryColor,
                    child: SmallBodyText('Danışmanlarım', AppColors.backgroundColor),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          SmallText('İlerlemene ait bütün istatistikleri burada bulabilirsin.', AppColors.titleColor),
        ],
      ),
    );
  }
}
