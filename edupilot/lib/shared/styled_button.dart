import 'package:edupilot/theme.dart';
import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    required this.onPressed,
    required this.child,
    });

    final Function() onPressed;
    final Widget child;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: child,
    );
  }
}

class CollapseMenuButton extends StatelessWidget {
  const CollapseMenuButton({
    super.key,
    required this.onPressed,
    required this.child,
    });

    final Function() onPressed;
    final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: child,
    );
  }
}

class ProfileScreenButton extends StatelessWidget {
  const ProfileScreenButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.color,
  });

  final Function() onPressed;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: child
    );
  }
}