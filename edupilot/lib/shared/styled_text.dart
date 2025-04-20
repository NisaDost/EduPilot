import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class XSmallText extends StatelessWidget {
  const XSmallText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
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
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
class XSmallBodyText extends StatelessWidget {
  const XSmallBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class MediumText extends StatelessWidget {
  const MediumText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
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
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class MediumBodyText extends StatelessWidget {
  const MediumBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleSmall,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class LargeText extends StatelessWidget {
  const LargeText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.headlineMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class LargeBodyText extends StatelessWidget {
  const LargeBodyText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleMedium,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
class XLargeText extends StatelessWidget {
  const XLargeText(this.text, this.color, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.titleLarge,
        color: color,
      ),
      softWrap: true,
      textAlign: textAlign ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class CenterAlignedText extends StatelessWidget {
  const CenterAlignedText(this.text, this.color, {super.key});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(
        textStyle: Theme.of(context).textTheme.headlineSmall,
        color: color,
        textBaseline: TextBaseline.alphabetic,
      ),
      textAlign: TextAlign.center,
      softWrap: true,
    );
  }
}