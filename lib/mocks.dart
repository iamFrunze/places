import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_strings.dart';

const mockLat = 48.590539702478225;
const mockLot = 45.71223457198511;

const rangeStart = 0.0;
const rangeEnd = 10.0;
const range = RangeValues(rangeStart, rangeEnd);

final mocks = [sight1, sight2, sight3, sight4, sight5, sight6];
final historyMock = <String>[];

final sight1 = SightModel(
  name: 'КОФЕЙНОЕ МЕСТО ',
  lat: 48.59288,
  lon: 45.71948,
  url:
      'https://lh5.googleusercontent.com/p/AF1QipMibb54mBg1-vl6_j83NIDudzFxI4SiF0EE13en=w408-h459-k-no',
  details: '«Кофейное место» - варим ароматный кофе из свежеобжаренных зёрен!',
  type: AppStrings.cafe,
);
final sight2 = SightModel(
  name: 'Городской стадион',
  lat: 48.6152,
  lon: 45.71297,
  url:
      'https://lh5.googleusercontent.com/p/AF1QipOk2jgn0YB2qdnGF0ppEXJsZeQkxOhCBXESx8c6=w426-h240-k-no',
  details: 'Место для отдыха и спорта',
  type: AppStrings.specialPlace,
);
final sight3 = SightModel(
  name: 'Памятник "Штык"',
  lat: 48.58375351090282,
  lon: 45.74011366780456,
  url:
      'https://lh5.googleusercontent.com/p/AF1QipPLxOUk4b_p4YfLrADGGjMSO6zR3ATyohILYdSk=w600-h450-p-k-no',
  details:
      'Монументальное изваяние, являющееся логическим и планировочным завершением аллеи космонавтов, '
      'в простонародии именуемой как "солдатский парк", '
      'идущей параллельно улице 9 мая от Храма до военной пожарной команды.',
  type: AppStrings.park,
);

final sight4 = SightModel(
  name: 'Солдатский парк',
  lat: 48.585827159018315,
  lon: 45.72909714394517,
  url:
      'https://nailizakon.com/fotogalereya/city08_z/znamensk/soldatskiy_park_1955.jpg',
  details:
      'Городская история начинается с основания в 1947 году военного полигона близ села Капустин Яр. '
      'Сначала строители и военные были расквартированы в землянках, палатках и домах села Капустин Яр, '
      'с 1949 года начали появляться первые финские домики, с 1951 году строится капитальные двухэтажные дома, казармы, административные здания Знаменска.',
  type: AppStrings.park,
);

final sight5 = SightModel(
  name: 'Памятник собакам - покорителям космоса',
  lat: 48.58180578565603,
  lon: 45.732913116277835,
  url:
      'https://lh5.googleusercontent.com/p/AF1QipNgw69yX5EZ6gcOFcQVFaa3LA12ToSjSEJ1LlAH=w408-h272-k-no',
  details:
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. ',
  type: AppStrings.park,
);

final sight6 = SightModel(
  name: 'Филиал музея РВСН',
  lat: 48.58567699912131,
  lon: 45.73384875432933,
  url:
      'https://lh5.googleusercontent.com/p/AF1QipMsTF88bM9QxaalFhJqgzlTfbaulr_CtXtGda4P=w426-h240-k-no',
  details: 'Отличный музей военной техники',
  type: AppStrings.museum,
);
