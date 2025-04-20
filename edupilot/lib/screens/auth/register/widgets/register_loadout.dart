import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class RegisterLoadout extends StatelessWidget {
  const RegisterLoadout({
    super.key,
    required this.title,
    required this.infoButtonOnPressed,
    required this.pageNumber,
  });

  final String title;
  final VoidCallback infoButtonOnPressed;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 4, // How soft the shodow is
                offset: Offset(0, 4), // Horizontal & Vertical offset
              ),
            ],
            color: AppColors.backgroundColor
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 64, right: 20, bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 4, // How soft the shodow is
                      offset: Offset(0, 4), // Horizontal & Vertical offset
                    ),
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStep('1', isActive: pageNumber == 1 ? true : false),
                    _buildLine(),
                    _buildStep('2', isActive: pageNumber == 2 ? true : false),
                    _buildLine(),
                    _buildStep('3', isActive: pageNumber == 3 ? true : false),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: LargeBodyText(
                        title,
                        AppColors.secondaryColor,
                        textAlign: TextAlign.left,
                        maxLines: 2, // Optional: control how many lines it wraps to
                      ),
                    ),
                    IconButton(
                      onPressed: infoButtonOnPressed,
                      icon: Icon(Icons.info, color: AppColors.primaryColor, size: 48),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep(String number, {required bool isActive}) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.secondaryColor : AppColors.primaryAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LargeBodyText(
        number, 
        isActive ? AppColors.primaryAccent : AppColors.backgroundColor
      )
    );
  }

  Widget _buildLine() {
    return Container(
      width: 113.71,
      height: 3,
      color: AppColors.primaryAccent,
    );
  }
}

class InfoRow extends StatelessWidget {
  final Widget? leading;
  final String text;

  const InfoRow({
    super.key,
    this.leading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading != null) leading!,
        if (leading != null) const SizedBox(width: 4),
        Expanded(
          child: XSmallBodyText(text, AppColors.textColor)),
      ],
    );
  }
}