import 'package:edupilot/screens/home/home.dart';
import 'package:edupilot/screens/login_register/demo.dart';
import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 3; // Default selected icon

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.all(0),
      color: AppColors.primaryColor,
      child: Container(
        color: AppColors.primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildBarItem(Icons.card_giftcard, 0),
            _buildBarItem(Icons.book, 1),
            _buildBarItem(Icons.timer, 2),
            _buildBarItem(Icons.airplanemode_active, 3, rotate: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBarItem(IconData icon, int index, {bool rotate = false}) {
    bool isActive = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
            switch (selectedIndex) {
              case 0: // redeem
                
                break;
              case 1: // ajanda
              
                break;
              case 2: // simulation
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) => const Demo())
                );
                break;
              case 3: // Home
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) => const Home())
                );
                break;
              default:
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryAccent : Colors.transparent,
          ),
          child: Center(
            child: Transform.rotate(
              angle: rotate ? 0.785 : 0, // 45 degrees rotation for airplane icon
              child: Icon(
                icon,
                color: isActive ? AppColors.highlightColor : AppColors.backgroundColor,
                size: 45, // Slightly reduce icon size for better fit
              ),
            ),
          ),
        ),
      ),
    );
  }
}
