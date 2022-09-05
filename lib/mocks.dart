import 'package:flutter/material.dart';
import 'package:places/data/sight_model.dart';
import 'package:places/res/app_strings.dart';

const mockLat = 48.590539702478225;
const mockLot = 45.71223457198511;

const rangeStart = 0.0;
const rangeEnd = 10.0;
const range = RangeValues(rangeStart, rangeEnd);

final mocks = [sight1, sight2, sight3, sight4, sight5];
final visitedSightsMock = [sight1, sight2, sight3, sight4, sight5];
final wantToVisitSightsMock = [sight1, sight2, sight3, sight4, sight5];
final historyMock = <String>[];

final sight1 = SightModel(
  id: 1,
  name: 'КОФЕЙНОЕ МЕСТО ',
  lat: 48.59288,
  lon: 45.71948,
  url: 'https://10619-2.s.cdn12.com/rests/small/w285/109_511274391.jpg',
  details: '«Кофейное место» - варим ароматный кофе из свежеобжаренных зёрен!'
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. ',
  type: AppStrings.cafe,
);
final sight2 = SightModel(
  id: 2,
  name: 'Городской стадион',
  lat: 48.6152,
  lon: 45.71297,
  url:
      'https://elastomer.org/upload/iblock/5be/5be664a9db5df35bdafe1f15cf5ba8ed.jpg',
  details: 'Место для отдыха и спорта',
  type: AppStrings.specialPlace,
);
final sight3 = SightModel(
  id: 3,
  name: 'Памятник "Штык"',
  lat: 48.58375351090282,
  lon: 45.74011366780456,
  url: 'http://www.volh.in/wp-content/uploads/2017/07/DSCN9324.jpg',
  details:
      'Монументальное изваяние, являющееся логическим и планировочным завершением аллеи космонавтов, '
      'в простонародии именуемой как "солдатский парк", '
      'идущей параллельно улице 9 мая от Храма до военной пожарной команды.',
  type: AppStrings.park,
);

final sight4 = SightModel(
  id: 4,
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
  id: 5,
  name: 'Памятник собакам - покорителям космоса',
  lat: 48.58180578565603,
  lon: 45.732913116277835,
  url: 'https://www.tury.ru/img.php?gid=334010&pid=2682761&v=1200',
  details:
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. '
      'Новый виток в освоении космоса связан с именем 2-х летней дворняжки Лайки, '
      'которая 3 ноября 1957-го совершила первый орбитальный полет вокруг Земли. '
      'Эта тихая и очень ласковая собака стала также первым хвостатым космонавтом, чье имя было "рассекречено" и стало известно всему миру. '
      'Однако долгое время о ее полете не сообщали всей правды, поскольку она была очень грустной. ',
  type: AppStrings.park,
);
