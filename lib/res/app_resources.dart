import 'package:flutter/material.dart';

class AppStrings {
  static const btnRoute = 'ПОСТРОИТЬ МАРШРУТ';
  static const plan = 'Запланировать';
  static const addToFavourite = 'В избранное';
  static const interestingPlaces = 'Список\nинтересных мест';
  static const heroTagCard = 'cardHero';
}

class AppAssets {
  static const calendar = 'res/svg/calendar_icon.svg';
  static const heart = 'res/svg/heart_icon.svg';
  static const route = 'res/svg/route_icon.svg';
}

class AppTypography {
  static const textText32Bold = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
  );
  static const textText24Bold = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
  );
  static const textText14Bold = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
  );
  static const textText16Medium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
  static const textText14Regular = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );
}

class AppColors {
  static const cardColor = Color(0xfff5f5f5);
  static const detailsCardColor = Color(0xff7C7E92);
  static const workingHoursColor = Color(0xff7C7E92);
}

class AppDimensions {
  static const margin16 = 16.0;
  static const margin24 = 24.0;
  static const margin32 = 32.0;
  static const margin64 = 64.0;

  static const cornerRadius16 = 16.0;
  static const cornerRadius12 = 12.0;
  static const cornerRadius10 = 10.0;

  static const aspectRatio3to2 = 3 / 2;
}
