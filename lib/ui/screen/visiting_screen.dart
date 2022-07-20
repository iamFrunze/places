import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/res/app_assets.dart';
import 'package:places/ui/screen/favourite/favourite_screen.dart';
import 'package:places/ui/screen/list/sight_list_screen.dart';

class VisitingScreen extends State with SingleTickerProviderStateMixin {
  final _barItems = [
    BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.list), label: ''),
    BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.map), label: ''),
    BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.heartFill), label: ''),
    BottomNavigationBarItem(icon: SvgPicture.asset(AppAssets.settings), label: ''),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          const SightListScreen(),
          const Center(
            child: Text('Map'),
          ),
          FavouriteScreen(),
          const Center(
            child: Text('Settings'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _barItems,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _tabController.index,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int currentIndex) {
    setState(() {
      _tabController.animateTo(currentIndex);
    });
  }
}
