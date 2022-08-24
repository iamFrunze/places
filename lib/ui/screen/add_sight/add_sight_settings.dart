import 'package:flutter/material.dart';
import 'package:places/data/repository/sights_repository.dart';

class AddSightSettings extends ChangeNotifier {
  final SightRepository repository;
  final mockImages = [
    'https://www.treehugger.com/thmb/Yz5imFySskfzWEEFphWtqDIqdcE=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-166152657-cb61ca0fd49e453cb4f1a60b50d281e7.jpg',
    'https://www.birdlife.org/wp-content/uploads/2021/06/Owl-in-tree-by-Philip-Brown-1-1024x576.jpg',
    'http://www.adoptananimalkits.com/files/547756/catitems/Barn_Owl-5ac510a90bff9b2cf198640d04e214bc.jpg',
    'https://www.thoughtco.com/thmb/umdna-6U5G71jeYQwrd3cpbb96k=/1500x1500/smart/filters:no_upscale()/153812237-56a008545f9b58eba4ae8f00.jpg',
    'https://www.nps.gov/articles/000/images/GGO_spread-wings_Mel-Clements.jpg?maxwidth=1200&autorotate=false',
    'https://chorus.stimg.co/23256340/merlin_34760037.jpg?fit=crop&crop=faces',
    'https://worldbirds.com/wp-content/uploads/2020/02/how-to-attract-owls.jpg',
  ];

  AddSightSettings({
    required this.repository,
  });

  void removeImage(String image) {
    mockImages.remove(image);
    notifyListeners();
  }

  void addImage() {
    mockImages.insert(
      0,
      'https://chorus.stimg.co/23256340/merlin_34760037.jpg?fit=crop&crop=faces',
    );
    notifyListeners();
  }
}
