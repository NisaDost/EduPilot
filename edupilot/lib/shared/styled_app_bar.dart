import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class StyledAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StyledAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // menu iconu
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.menu, 
              color: AppColors.backgroundColor,
              size: 40,
            ),
          ),

          // search bar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.backgroundColor.withValues(alpha: 0.75),
                  prefixIcon: Icon(Icons.search, 
                    color: Colors.grey[700],
                    size: 24,
                  ),
                  
                  hintText: 'Ara?',
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColors.backgroundColor.withValues(alpha: 0.75)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12), // Shrinks vertically
                  constraints: BoxConstraints(minHeight: 36, maxHeight: 36), // Limits height
                ),
              ),
            ),
          ),

          // uygulama ismi ve profil resmi
          Row(
            children: [
              StyledTitle('EduPilot', AppColors.backgroundColor),
              const SizedBox(width: 16),
              CircleAvatar(
                backgroundColor: AppColors.backgroundColor,
                radius: 24,
                child: Icon(Icons.person, 
                  color: AppColors.primaryColor,
                  size: 48,
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}