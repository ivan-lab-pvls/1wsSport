// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'news/newsScreen.dart';
import 'presentation/calendar/cale/CalendarPage.dart';
import 'presentation/matc/view/mainData.dart';
import 'settings.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const MatchBoardScreen(),
    const PageOfNewsForShow(),
    CalendarScreenPage(),
    const Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: const Color.fromARGB(255, 7, 7, 10),
        activeColor: Colors.orange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.wand_rays_inverse),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.news),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.settings_solid,
            ),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return _pages[index];
          },
        );
      },
    );
  }
}
