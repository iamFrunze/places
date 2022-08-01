import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/ui/screen/favourite/favourite_screen.dart';
import 'package:places/ui/screen/list/sight_list_screen.dart';
import 'package:places/ui/screen/settings/settings_screen.dart';

class NavScreen extends State with SingleTickerProviderStateMixin {
  final _pages = [
    const SightListScreen(),
    const Center(
      child: Text('Map'),
    ),
    FavouriteScreen(),
    const SettingsScreen(),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _tabController.index;

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 0 ? AppAssets.listFill : AppAssets.list,
              color: _itemColor(currentIndex == 0),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 1 ? AppAssets.mapFill : AppAssets.map,
              color: _itemColor(currentIndex == 1),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 2 ? AppAssets.heartFill : AppAssets.heart,
              color: _itemColor(currentIndex == 2),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              currentIndex == 3 ? AppAssets.settingsFill : AppAssets.settings,
              color: _itemColor(currentIndex == 3),
            ),
            label: '',
          ),
        ],
        currentIndex: _tabController.index,
        onTap: _onItemTapped,
      ),
    );
  }

  Color? _itemColor(bool current) {
    return current
        ? Theme.of(context).bottomNavigationBarTheme.selectedItemColor
        : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
  }

  void _onItemTapped(int currentIndex) {
    setState(() {
      _tabController.animateTo(currentIndex);
    });
  }
}
