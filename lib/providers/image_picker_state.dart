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

    final directoryImages = '${directory.path}/images';
    final appImages = Directory(directoryImages);

    if (!appImages.existsSync()) {
      await appImages.create();
    }

    final directoryVehicles = '${directory.path}/images/vehicles';
    final appVehicles = Directory(directoryVehicles);

    if (!appVehicles.existsSync()) {
      await appVehicles.create();
    }
    final plateVehicle = plate.trim();
    final directoryVehicle = '${appVehicles.path}/$plateVehicle';
    final appPlate = Directory(directoryVehicle);

    if (!appPlate.existsSync()) {
      await appPlate.create(recursive: true);
    }

    for (var image = 0; image < _photoVehicles.length; image++) {
      final vehiclesPhoto = _photoVehicles[image];
      final imageVehicle = File('${appPlate.path}/$image.png');
      final bytes = await vehiclesPhoto.readAsBytes();

      await imageVehicle.writeAsBytes(bytes);
    }
  }

  ///Pega uma única foto de cada veículo
  Future<String> getImageVehicle(String plate) async {
    final directory = await getApplicationSupportDirectory();
    final imageVehicle = '${directory.path}/images/vehicles/$plate/0.png';
    return imageVehicle;
  }
}
