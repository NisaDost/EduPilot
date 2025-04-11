import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.jomhuria(
      textStyle: Theme.of(context).textTheme.bodyMedium,
      color: color,
    ));
  }
}

class StyledHeading extends StatelessWidget {
  const StyledHeading(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.jomhuria(
      textStyle: Theme.of(context).textTheme.headlineMedium,
      color: color,
    ));
  }
}

class StyledTitle extends StatelessWidget {
  const StyledTitle(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.jomhuria(
      textStyle: Theme.of(context).textTheme.titleMedium,
      color: color,
    ));
  }
}

class CardText extends StatelessWidget {
  const CardText(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.jomhuria(
      textStyle: Theme.of(context).textTheme.bodySmall,
      color: color,
      textBaseline: TextBaseline.alphabetic,
    ));
  }
}

class CardTitle extends StatelessWidget {
  const CardTitle(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.jomhuria(
      textStyle: Theme.of(context).textTheme.titleSmall,
      color: color,
    ));
  }
}