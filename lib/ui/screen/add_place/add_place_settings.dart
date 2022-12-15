import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/data/interactors/remote/place_interactor_remote.dart';
import 'package:places/data/model/place_model.dart';

class AddPlaceSettings extends ChangeNotifier {
  final _images = <File>[];
  final PlaceInteractorRemote _interactor;
  final _imagePicker = ImagePicker();

  List<File> get images => _images;

  double? _lat;
  double? _lng;
  String? _name;
  List<String>? _urls;
  String? _placeType;
  String? _description;

  AddPlaceSettings(this._interactor);

  void removeImage(File image) {
    _images.remove(image);
    notifyListeners();
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
    await _interactor.uploadImages(images);
    notifyListeners();
  }

  Future<void> fetchPictureFromCamera() async {
    final image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final file = File(image.path);
      _images.insert(0, file);
      notifyListeners();
    }
  }

  Future<void> fetchPictureFromGallery() async {
    final image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final file = File(image.path);
      _images.insert(0, file);
      notifyListeners();
    }
  }
}
