import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class XSmallText extends StatelessWidget {
  const XSmallText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.labelSmall,
        color: color,
        textBaseline: TextBaseline.alphabetic,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.bodySmall,
        color: color,
        textBaseline: TextBaseline.alphabetic,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}
class SmallBodyText extends StatelessWidget {
  const SmallBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.headlineSmall,
        color: color,
        textBaseline: TextBaseline.alphabetic,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class MediumBodyText extends StatelessWidget {
  const MediumBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleSmall,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class LargeText extends StatelessWidget {
  const LargeText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.headlineMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}

class LargeBodyText extends StatelessWidget {
  const LargeBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
class XLargeText extends StatelessWidget {
  const XLargeText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleLarge,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}

class CouponCardText extends StatelessWidget {
  const CouponCardText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.labelLarge,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
    );
  }
}