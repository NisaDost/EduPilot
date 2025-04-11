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

          // // search bar
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 12),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: AppColors.backgroundColor.withAlpha(190),
          //         prefixIcon: Icon(
          //           Icons.search,
          //           color: Colors.grey[700],
          //           size: 24,
          //         ),
          //         hintText: 'Ara?',
          //         hintStyle: TextStyle(
          //           color: Colors.grey[700],
          //         ),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(8),
          //           borderSide: BorderSide(
          //             color: AppColors.backgroundColor.withAlpha(190),
          //           ),
          //         ),
          //         contentPadding:
          //             const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          //         constraints:
          //             const BoxConstraints(minHeight: 36, maxHeight: 36),
          //       ),
          //     ),
          //   ),
          // ),

          Expanded(child: SizedBox()),

          // app name & profile icon
          Row(
            children: [
              StyledTitle('EduPilot', AppColors.backgroundColor),
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