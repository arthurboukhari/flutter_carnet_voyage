import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/ui/screens/home_screen.dart';
import 'package:flutter_carnet_voyage/ui/screens/profile_screen.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  Widget _home = Home();
  Widget _profile = Profile();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlue,
          onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getBody(int index) {
    if (index == 0) {
      return _profile;
    } else if (index == 1) {
      return _home;
    }
    return _profile;
  }
}
