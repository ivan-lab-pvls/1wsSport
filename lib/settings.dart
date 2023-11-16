import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:in_app_review/in_app_review.dart';

import 'news/setbtn.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color.fromARGB(255, 7, 7, 10),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              fasdfascas(
                fixa: 'Rate App',
                da: '',
                onTap: () {
                  // inAppReview.openStoreListing(appStoreId: '6467123708');
                },
              ),
              fasdfascas(
                fixa: 'Privacy Policy',
                da: '',
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ShowUI(
                        url:
                            'https://docs.google.com/document/d/1PuEL9YqW7HfA3r9ZpcvFzru44tmh2P1P58_DMgHQg2c/edit?usp=sharing',
                        name: 'Privacy Policy',
                      ),
                    ),
                  );
                },
              ),
              fasdfascas(
                fixa: 'Terms & Conditions',
                da: '',
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ShowUI(
                        url:
                            'https://docs.google.com/document/d/1U9n2Q4ht5Q1EpQtteVd69qoTg-VeUiCkLlz-uqedYYE/edit?usp=sharing',
                        name: 'Terms & Conditions',
                      ),
                    ),
                  );
                },
              ),
              fasdfascas(
                fixa: 'Support',
                da: '',
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ShowUI(
                        url: 'https://forms.gle/WD4SqZQgL3qm2Kz98',
                        name: 'Support',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowUI extends StatelessWidget {
  late String url;
  late String name;
  // ignore: use_key_in_widget_constructors
  ShowUI({required this.url, required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(url),
        ),
      ),
    );
  }
}
