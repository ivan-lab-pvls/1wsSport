import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HelpDeskView extends StatelessWidget {
  final String show;

  const HelpDeskView({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          bottom: false,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(show)),
          ),
        ),
      ),
    );
  }
}
