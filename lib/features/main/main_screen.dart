import 'package:flutter/material.dart';
import 'package:target_manager/features/main/result_list_screen.dart';
import 'package:target_manager/features/main/setting_screen.dart';
import 'package:target_manager/features/main/shoot_record_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const NumberPad(),
    const ResultListScreen(),
    const InfoBox(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ads_click),
            label: 'Shooting Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Data History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_sharp),
            label: 'How To Use',
          ),
        ],
      ),
    );
  }
}
