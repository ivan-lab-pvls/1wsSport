// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTextOfNewsCard extends StatelessWidget {
  MainTextOfNewsCard({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.unbounded(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        decoration: TextDecoration.none,
        color: Colors.white,
      ),
    );
  }
}

class BigTextOfNews extends StatelessWidget {
  BigTextOfNews({Key? key, required this.text}) : super(key: key);
  String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      style: GoogleFonts.unbounded(
        fontWeight: FontWeight.w600,
        color: const Color(
          0xFFFFFFFF,
        ),
        decoration: TextDecoration.none,
        fontSize: 12,
      ),
    );
  }
}

class SmallTextOfNews extends StatelessWidget {
  SmallTextOfNews({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.unbounded(
        fontWeight: FontWeight.w400,
        color: const Color(
          0xFF55566E,
        ),
        fontSize: 11,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class MoreTextOFNews extends StatelessWidget {
  MoreTextOFNews({Key? key, required this.text}) : super(key: key);
  String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.unbounded(
        fontWeight: FontWeight.w400,
        color: const Color(
          0xFF82839A,
        ),
        fontSize: 10,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class DefaultTextOfNews extends StatelessWidget {
  DefaultTextOfNews({Key? key, required this.text}) : super(key: key);

  String text;
  @override
  Widget build(BuildContext context) {
    return  Text(
      text,
      style: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
          decoration: TextDecoration.none),
    );
  }
}
