import 'package:flutter/material.dart';
import 'package:projectsalon/categories.dart';
import 'package:projectsalon/pages/profile/profile_screen.dart';
import 'package:projectsalon/pages/search.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        children: [
          new HomeScreen(),
          new Categories(),
          new ProfileScreen(),
        ],
        controller: _pageController,
        onPageChanged: pageChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(items: [
        new BottomNavigationBarItem(
            icon: new Icon(Icons.search), title: new Text('search')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.category), title: new Text('Categories')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.person), title: new Text('Profile')),
      ], onTap: navigationTapped, currentIndex: _page),
    );
    // ignore: dead_code
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void pageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
