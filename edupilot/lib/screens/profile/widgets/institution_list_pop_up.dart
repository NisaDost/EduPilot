import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class InstitutionListPopUp extends StatelessWidget {
  const InstitutionListPopUp({
    super.key,
    this.institutionName,
  });

  final String? institutionName;

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
              MediumBodyText('Okulun', AppColors.titleColor),
              const SizedBox(height: 16),
              if (institutionName == null || institutionName!.isEmpty)
                Center(
                  child: SmallBodyText(
                    'Kayıtlı olduğun bir okul bulamadık.',
                    AppColors.textColor,
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("• ", style: TextStyle(color: AppColors.secondaryColor, fontSize: 24)),
                            Expanded(
                              child: MediumBodyText(
                                institutionName!,
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