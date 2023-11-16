import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winnerfootball/news/data.dart';

import 'const.dart';

class NewsWidgetDataCard extends StatelessWidget {
  NewsWidgetDataCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: [
                  Image.network(FootballNewsData.stats[index].img),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          BigTextOfNews(text: FootballNewsData.stats[index].title),
          const SizedBox(
            height: 4,
          ),
          SizedBox(
            height: 38,
            child:
                SmallTextOfNews(text: FootballNewsData.stats[index].description),
          )
        ],
      ),
    );
  }
}
