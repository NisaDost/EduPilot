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
        backgroundColor: Color.fromRGBO(217, 217, 217, 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: child,
    );
  }
}