import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:places/data/repository/sights_repository.dart';
import 'package:places/data/repository/want_visit_sights_repository.dart';
import 'package:places/data/sight_model.dart';

class SightDetailsSettings extends ChangeNotifier {
  final SightRepository repository;
  final WantToVisitSightsRepository wantVisitRepository;

  int get currentIndex => _currentIndex;
  SightModel? get currentSight => _currentSight;

  int _currentIndex = 0;

  late List<SightModel> _sights;
  SightModel? _currentSight;

  SightDetailsSettings({
    required this.repository,
    required this.wantVisitRepository,
  }) {
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

  SightModel? fetchSight(int id) {
    _currentSight = _sights.firstWhere((element) => element.id == id);

    return _currentSight;
  }

  void updatePlanningDateSight(DateTime date) {
    _currentSight = _currentSight?.copyWith(
      planningDate: formatDate(
        date,
        [dd, ' ', M, ' ', yy],
        locale: const RussianDateLocale(),
      ),
    );
    if (_currentSight != null) {
      repository.updateSight(_currentSight!);
      wantVisitRepository.add(_currentSight!);
    }
    notifyListeners();
  }
}
