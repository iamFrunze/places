import 'package:flutter/material.dart';
import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/sight_model.dart';

class SightDetailsSettings extends ChangeNotifier {
  final SightRepository repository;

  int get currentIndex => _currentIndex;

  int _currentIndex = 0;

  late List<SightModel> _sights;

  SightDetailsSettings({required this.repository}) {
    final callback = repository.fetchSights();
    if (callback != null) {
      _sights = callback;
    } else {
      throw Exception('Cannot fetch data');
    }
  }

  void onPageChange(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  SightModel fetchSight(int id) =>
      _sights.firstWhere((element) => element.id == id);
}
