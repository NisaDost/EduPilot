import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class SupervisorsListPopUp extends StatelessWidget {
  const SupervisorsListPopUp({
    super.key,
    this.supervisorsList,
  });

  final List<String>? supervisorsList;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.maxFinite,
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediumBodyText('Danışmanların', AppColors.titleColor),
              const SizedBox(height: 16),
              if (supervisorsList == null || supervisorsList!.isEmpty)
                Center(
                  child: SmallBodyText(
                    'Herhangi bir danışman bulamadık.',
                    AppColors.textColor,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: supervisorsList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("• ", style: TextStyle(color: AppColors.secondaryColor, fontSize: 24)),
                            Expanded(
                              child: MediumBodyText(
                                supervisorsList![index],
                                AppColors.textColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
