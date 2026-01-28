import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/features/home/view/home_view.dart';
import 'package:realtime_coin/features/news/view/news_view.dart';
import 'package:realtime_coin/features/search/view/search_view.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomeView(), SearchView(), NewsView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: _Constants.backgroundColor,
        indicatorColor: _Constants.indicatorColor,
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(WidgetState.selected)) {
            return _Constants.selectedTextStyle;
          }
          return _Constants.unSelectedTextStyle;
        }),
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: _Constants.selectedIconColor),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(
              Icons.search,
              color: _Constants.selectedIconColor,
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(
              Icons.newspaper,
              color: _Constants.selectedIconColor,
            ),
            label: 'News',
          ),
        ],
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  // Colors
  static const Color indicatorColor = AppColors.primary;
  static const Color backgroundColor = AppColors.secondary;
  static const Color selectedIconColor = AppColors.secondary;

  // Text Styles
  static const selectedTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 12,
  );
  static const unSelectedTextStyle = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );
}
