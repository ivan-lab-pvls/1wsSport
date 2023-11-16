import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/const.dart';


// ignore: must_be_immutable
class fasdfascas extends StatelessWidget {
  fasdfascas({
    Key? key,
    required this.fixa,
    required this.da,
    required this.onTap,
  }) : super(key: key);

  String fixa;
  String da;
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigTextOfNews(text: fixa),
              const SizedBox(
                height: 8,
              ),
              SmallTextOfNews(text: da),
            ],
          ),
          onPressed: () => onTap()),
    );
  }
}