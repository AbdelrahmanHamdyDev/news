import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/views/home_page.dart';
import 'package:news/views/search_page.dart';
import 'package:news/widgets/standalone_AppBar.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandaloneAppBar(
        titleWidget: Text(
          (_currentIndex == 0) ? "News" : "Search",
          style: AppFonts.headlineLarge.copyWith(
            fontSize: 28.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onTapped,
        children: [HomePage(), SearchPage()],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        height: 50.h,
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTapped,
        indicatorColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: '',
          ),
        ],
      ),
    );
  }
}
