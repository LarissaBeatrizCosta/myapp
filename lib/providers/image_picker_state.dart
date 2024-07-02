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

  ///Lista para adicionar arquivo dos veiculos
  final List<String> _photoVehiclesPaths = [];

  ///Lista de fotos dos veiculos
  List<XFile> get photoVehicles => _photoVehicles;

  ///Lista de arquivos do veículo
  List<String> get photoVehiclesPaths => _photoVehiclesPaths;

  ///Método para adicionar fotos da galeria
  Future<void> getImageFromGallery() async {
    final selectedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      _photoVehicles.add(selectedImage);
      notifyListeners();
    }
  }

  ///Método para adicionar fotos com a câmera
  Future<void> getImageFromCamera() async {
    final photoVehicle =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (photoVehicle != null) {
      _photoVehicles.add(photoVehicle);
      notifyListeners();
    }
  }

  ///Método para salvar as fotos dos veiculos
  Future<void> saveImageVehicle(String plate) async {
    final directory = await getApplicationSupportDirectory();
    final imageDirectory = Directory('${directory.path}/images');
    final vehicleDirectory = Directory('${imageDirectory.path}/$plate');

    if (!imageDirectory.existsSync()) {
      await imageDirectory.create(recursive: true);
    }
    if (!vehicleDirectory.existsSync()) {
      await vehicleDirectory.create(recursive: true);
    }

    for (var image = 0; image < _photoVehicles.length; image++) {
      final vehicleImages = _photoVehicles[image];

      final directoryNameVehicle = 'vehicle_$image';

      final photoVehicleDirectory =
          Directory('${vehicleDirectory.path}/$directoryNameVehicle');
      if (!photoVehicleDirectory.existsSync()) {
        await photoVehicleDirectory.create();
      }

      final photoVehicle = File('${photoVehicleDirectory.path}/$image.png');
      await vehicleImages.saveTo(photoVehicle.path);

      _photoVehiclesPaths.add(photoVehicle.path);
    }

    _photoVehicles.clear();
    notifyListeners();
  }

  ///Pega as fotos salvas de cada veículo
  Future<List<String>> getImagesVehicle(String plate) async {
    final directory = await getApplicationSupportDirectory();
    final vehicleDirectory =
        Directory('${directory.path}/images/vehicles/$plate');

    if (!vehicleDirectory.existsSync()) {
      return [];
    }

    var imageVehicles = <String>[];
    for (var image in vehicleDirectory.listSync()) {
      imageVehicles.add(image.path);
    }
    return imageVehicles;
  }
}
