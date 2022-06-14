import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motorly/app/modules/home/widgets/camera_widget.dart';

class SelectImageService {
  Future<Either<String, PickedFile>> fetchFromGallery() async {
    try {
      final image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1280,
        maxHeight: 720,
      );

      if (image == null) return Left("Aborted the scanner from gallery.");
      return Right(image);
    } on FileSystemException {
      return Left("Not found by gallery");
    }
  }

  Future<Either<String, PickedFile>> fetchFromCamera(
      BuildContext context) async {
    // try {
    //   final image = await ImagePicker().getImage(
    //     source: ImageSource.camera,
    //     maxWidth: 800,
    //     maxHeight: 600,
    //     preferredCameraDevice: CameraDevice.rear,
    //   );

    //   if (image == null) return Left("Aborted the scanner from camera.");

    //   return Right(image);
    // } on FileSystemException {
    //   return Left("Not found by camera");
    // }
    try {
      final cameras = await availableCameras();
      // Selecting the first camera from available cameras
      final firstCamera = cameras.first;
      PickedFile photo;
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraWidget(
              onTap: (image) {
                photo = PickedFile(image.path);
              },
              camera: firstCamera,
            ),
          ));
      if (photo == null) return Left("Aborted the scanner from camera.");
      print("------------------------------------");
      print(photo.path);
      print("------------------------------------");
      return Right(photo);
    } catch (e) {
      return Left("Not found by camera");
    }
  }
}
