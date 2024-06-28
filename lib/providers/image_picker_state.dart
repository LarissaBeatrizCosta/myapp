import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///Classe para adicionar fotos dos veiculos
class ImagePickerState extends ChangeNotifier {
  ///Instancia do ImagePicker
  final imagePicker = ImagePicker();

  ///Método para adicionar fotos da galeria
  Future<void> getImageFromGallery() async {
    final photoVehicle = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (photoVehicle != null) {
      notifyListeners();
    }
  }

  ///Método para adicionar fotos com a câmera
  void getImageFromCamera() async {
    final photoVehicle = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (photoVehicle != null) {
      notifyListeners();
    }
  }

//   ///Lista para adicionar fotos dos veiculos
//   final List<File> _photoVehicles = [];

//   ///Lista de fotos dos veiculos
//   List<File> get photoVehicles => _photoVehicles;

//   ///Método para adicionar fotos dos veiculos
//   void insertPhoto(File photo) {
//     _photoVehicles.add(photo);
//     notifyListeners();
//   }

//   ///Método para remover fotos dos veiculos
//   void removePhoto(int photo) {
//     _photoVehicles.removeAt(photo);
//     notifyListeners();
//   }

//   ///Método para salvar as fotos dos veiculos
//   Future<void> saveImageVehicle() async {
//     final file = await getApplicationDocumentsDirectory();

//     for (var image = 0; image < _photoVehicles.length; image++) {
//       final photosVehiclesPath = '${file.path}/image_$image.png';
//       await _photoVehicles[image].copy(photosVehiclesPath);
//     }
//   }

//   ///Método para pegar as fotos dos veiculos
//   // Future<void> getImage() async {
//   //   final File? image =
//   //       await photoVehicles.getImage(source: ImageSource.gallery);
//   // }
}
