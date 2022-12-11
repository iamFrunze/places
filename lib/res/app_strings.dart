class AppStrings {
  static const btnRoute = 'ПОСТРОИТЬ МАРШРУТ';
  static const plan = 'Запланировать';
  static const addToFavourite = 'В избранное';
  static const interestingPlaces = 'Список интересных мест';
  static const wantToVisit = 'Хочу посетить';
  static const visited = 'Посетил';
  static const favourite = 'Избранное';
  static const map = 'Карта';
  static const empty = 'Пусто';
  static const markFavouritePlaces =
      'Отмечайте понравившиеся\nместа и они появиятся здесь.';
  static const completeRoute = 'Завершите маршрут,\nчтобы место попало сюда.';
  static const error = 'Ошибка';
  static const errorDescription = 'Что то пошло не так\nПопробуйте позже.';

  /// App
  static const from = 'от';
  static const to = 'до';
  static const km = 'км';
  static const notSelected = 'Не выбрано';
  static const nameSight = 'название';
  static const latitude = 'широта';
  static const longitude = 'долгота';
  static const cancel = 'Отмена';
  static const description = 'описание';
  static const inputText = 'введите текст';
  static const create = 'создать';
  static const category = 'Категория';

  /// Category screen
  static const categories = 'категории';
  static const hotel = 'Отель';
  static const restaurant = 'Ресторан';
  static const specialPlace = 'Особое место';
  static const park = 'Парк';
  static const museum = 'Музей';
  static const cafe = 'Кафе';
  static const distance = 'Расстояние';
  static const clear = 'Очистить';

  /// Settings screen
  static const settings = 'Настройки';
  static const darkTheme = 'Тёмная тема';
  static const tutorial = 'Смотреть туториал';

  /// New sight
  static const newSight = 'Новое место';
  static const showOnMap = 'Указать на карте';
  static const save = 'сохранить';

  static const search = 'Поиск';

  static const youSearch = 'вы искали';
  static const clearHistory = 'Очистить историю';
  static const notFound = 'Ничего не найдено.';
  static const tryChangeSearchParams = 'Попробуйте изменить параметры поиска';
  static const remove = 'Удалить';

  /// OnBoarding
  static const skip = 'Пропустить';
  static const title1 = 'Добро пожаловать в Путеводитель';
  static const subtitle1 = 'Ищи новые локации и сохраняй самые любимые.';
  static const title2 = 'Построй маршрут и отправляйся в путь';
  static const subtitle2 = 'Достигай цели максимально быстро и комфортно.';
  static const title3 = 'Добавляй места, которые нашёл сам';
  static const subtitle3 =
      'Делись самыми интересными и помоги нам стать лучше!';
  static const onStart = 'на старт';

  /// Cupertino action sheet
  static const camera = 'Камера';
  static const file = 'Файл';
  static const picture = 'Фотография';

  /// Dio request
  static const String filteredPlacesPath = '/filtered_places';
  static const String placePath = '/place';
  static const String uploadFilePath = '/upload_file';
  static const String clientPath = '/client';
  static const String filesPath = '/files';

  /// Shared Preferences keys
  static const String categoriesKey = 'categories_key';
  static const String fromRangeValueKey = 'from_range_value_key';
  static const String toRangeValueKey = 'to_range_value_key';
  static const String appThemeKey = 'app_theme_key';
  static const String firstLoginKey = 'first_login_key';

  static String show(int value) => 'показать ($value)';

  static String placeIdPath(int id) => '/place/$id';
}
