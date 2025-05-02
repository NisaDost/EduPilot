import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMenuOpen;
  final VoidCallback onMenuToggle;
  final VoidCallback onProfileTap;

  const CustomAppBar({
    super.key,
    required this.isMenuOpen,
    required this.onMenuToggle,
    required this.onProfileTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          // menu icon
          IconButton(
            onPressed: onMenuToggle,
            padding: const EdgeInsets.only(left: 0),
            icon: isMenuOpen
            ? Icon(
                Icons.close,
                color: AppColors.backgroundColor,
                size: 40,
              )
            : Icon(
                Icons.menu,
                color: AppColors.backgroundColor,
                size: 40,
              ),
          ),
          const Expanded(child: SizedBox()),

          // app name & profile icon
          Row(
            children: [
              LargeBodyText('EduPilot', AppColors.backgroundColor),
              const SizedBox(width: 16),
              IconButton(
                onPressed: onProfileTap, 
                icon: CircleAvatar(
                  backgroundColor: AppColors.backgroundColor,
                  radius: 24,
                  child: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                    size: 48,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}