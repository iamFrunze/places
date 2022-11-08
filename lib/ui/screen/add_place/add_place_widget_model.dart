import 'dart:async';
import 'dart:math';

import 'package:mwwm/mwwm.dart';
import 'package:places/data/interactors/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

class AddPlaceWM extends WidgetModel {
  final picturesStreamController = StreamController<List<String>>();
  final _mockImages = [
    'https://www.treehugger.com/thmb/Yz5imFySskfzWEEFphWtqDIqdcE=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-166152657-cb61ca0fd49e453cb4f1a60b50d281e7.jpg',
    'https://www.birdlife.org/wp-content/uploads/2021/06/Owl-in-tree-by-Philip-Brown-1-1024x576.jpg',
    'http://www.adoptananimalkits.com/files/547756/catitems/Barn_Owl-5ac510a90bff9b2cf198640d04e214bc.jpg',
    'https://www.thoughtco.com/thmb/umdna-6U5G71jeYQwrd3cpbb96k=/1500x1500/smart/filters:no_upscale()/153812237-56a008545f9b58eba4ae8f00.jpg',
    'https://www.nps.gov/articles/000/images/GGO_spread-wings_Mel-Clements.jpg?maxwidth=1200&autorotate=false',
    'https://chorus.stimg.co/23256340/merlin_34760037.jpg?fit=crop&crop=faces',
    'https://worldbirds.com/wp-content/uploads/2020/02/how-to-attract-owls.jpg',
  ];

  final PlaceInteractor _interactor;

  double? _lat;
  double? _lng;
  String? _name;
  List<String>? _urls;
  String? _placeType;
  String? _description;

  AddPlaceWM(WidgetModelDependencies baseDependencies, this._interactor)
      : super(baseDependencies) {
    picturesStreamController.add(_mockImages);
  }

  @override
  void dispose() {
    super.dispose();
    picturesStreamController.close();
  }

  void removeImage(String image) {
    _mockImages.remove(image);
    picturesStreamController.add(_mockImages);
  }

  void addImage() {
    _mockImages.insert(
      0,
      'https://chorus.stimg.co/23256340/merlin_34760037.jpg?fit=crop&crop=faces',
    );
    picturesStreamController.add(_mockImages);
  }

  Future<void> addPlace() async {
    final place = PlaceModel(
      id: Random.secure().nextInt(1000),
      lat: _lat ?? 0,
      lng: _lng ?? 0,
      name: _name ?? '',
      urls: _urls ?? [],
      placeType: _placeType ?? '',
      description: _description ?? '',
    );
    await _interactor.addNewPlace(place);
  }
}
