import 'package:edupilot/shared/styled_text.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CollapseMenu extends StatelessWidget {
  const CollapseMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryAccent,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // icon - user name-surname - grade - points - streak
          Row(
            children: [
              // icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.backgroundColor,
                    radius: 36,
                    child: Icon(Icons.person, 
                      color: AppColors.primaryAccent,
                      size: 72,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16,),
              // user name-surname - grade - points - streak
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CardTitle('Name Surname', AppColors.backgroundColor)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}