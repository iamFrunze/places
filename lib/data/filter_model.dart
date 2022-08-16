import 'package:flutter/material.dart';

class FilterModel {
  final List<String> category;
  final RangeValues rangeValues;

  FilterModel({
    required this.category,
    required this.rangeValues,
  });
}
