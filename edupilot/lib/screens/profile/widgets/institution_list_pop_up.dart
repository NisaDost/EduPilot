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
          child: (institutionName == null || institutionName!.trim().isEmpty)
            ? Center(
                child: XSmallBodyText(
                  'Kayıtlı olduğun bir okul bulunmuyor',
                  AppColors.textColor,
                ),
              )
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MediumBodyText('Okulun', AppColors.titleColor),
                    const SizedBox(height: 32),
                    MediumBodyText(institutionName!, AppColors.textColor),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}