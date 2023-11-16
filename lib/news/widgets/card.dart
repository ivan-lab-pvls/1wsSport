// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:winnerfootball/news/col.dart';
import 'const.dart';

class CardOfFootballNews extends StatelessWidget {
  CardOfFootballNews({Key? key, required this.title, required this.count})
      : super(key: key);

  String title;
  String count;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: colorxa,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallTextOfNews(text: title),
              const SizedBox(
                height: 8,
              ),
              BigTextOfNews(text: count)
            ],
          ),
        ),
      ),
    );
  }
}
