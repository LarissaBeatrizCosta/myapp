import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

///Classe para adicionar fotos dos veiculos
class ImagePickerState extends ChangeNotifier {
  ///Instancia do ImagePicker
  final _imagePicker = ImagePicker();

  ///Lista para adicionar fotos dos veiculos
  final List<XFile> _photoVehicles = [];

  ///Lista de fotos dos veiculos
  List<XFile> get photoVehicles => _photoVehicles;

  ///Método para adicionar fotos da galeria
  Future<void> getImageFromGallery() async {
    final photoVehicle = await _imagePicker.pickMultiImage();

    if (photoVehicle.isNotEmpty) {
      _photoVehicles.addAll(photoVehicle);
      notifyListeners();
    }

  }

  ///Método para adicionar fotos com a câmera
  void getImageFromCamera() async {
    final photoVehicle = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (photoVehicle != null) {
       _photoVehicles.add(photoVehicle);
      notifyListeners();
    }
  }

  ///Método para salvar as fotos dos veiculos
  Future<void> saveImageVehicle() async {
    final file = await getApplicationDocumentsDirectory();
    final directoryPhotos = Directory('${file.path}/images');

    if (await directoryPhotos.exists()) {
      await directoryPhotos.create(recursive: true);
    }
    for (var image = 0; image < _photoVehicles.length; image++) {
      final imagePath = '${directoryPhotos.path}/image_$image.png';
      final imageFile = File(_photoVehicles[image].path);
      await imageFile.copy(imagePath);
    }

    _photoVehicles.clear();
    notifyListeners();
  }
}
