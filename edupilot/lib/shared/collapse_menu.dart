import 'package:edupilot/shared/styled_button.dart';
import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CollapseMenu extends StatelessWidget {
  const CollapseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryAccent,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // name-surname
          CardTitle('Name Surname', AppColors.backgroundColor),
          const SizedBox(height: 12),
          // icon - grade - points - streak
          Row(
            children: [
              // icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    radius: 48,
                    child: Icon(Icons.person, 
                      color: AppColors.primaryAccent,
                      size: 96,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16,),
              // grade - points - streak
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // grade
                  Row(
                    children: [
                      Icon(Icons.school_rounded, color: AppColors.backgroundColor),
                      const SizedBox(width: 16),
                      CardText("8. Sınıf", AppColors.backgroundColor)
                    ],
                  ),
                  const SizedBox(height: 4),
                  // points
                  Row(
                    children: [
                      Icon(Icons.bolt, color: AppColors.backgroundColor),
                      const SizedBox(width: 16),
                      CardText("1205", AppColors.backgroundColor)
                    ],
                  ),
                  const SizedBox(height: 4),
                  //streak
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, color: AppColors.backgroundColor),
                      const SizedBox(width: 16),
                      CardText("5", AppColors.backgroundColor)
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 42),
          SizedBox(
            width: double.infinity,
            child: CollapseMenuButton(
              onPressed: () {}, 
              child: CardText('Collapse Menu Button 1', AppColors.backgroundColor),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CollapseMenuButton(
              onPressed: () {}, 
              child: CardText('Collapse Menu Button 2', AppColors.backgroundColor),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: CollapseMenuButton(
              onPressed: () {}, 
              child: CardText('Collapse Menu Button 3', AppColors.backgroundColor),
            ),
          ),
        ],
      ),
    );
  }
}