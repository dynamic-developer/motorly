import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PlateImageRepository {
  Future<Either<String, String>> verify(PickedFile image) async {
    var imageBase64 = await base64Encode(await image.readAsBytes());

    try {
      var postUri = Uri.parse(
          'https://api.platerecognizer.com/v1/plate-reader/'); //'https://openalpr-ov6qm7orwa-ts.a.run.app/?country_code=eu');

      var postHeaders = {
        'Authorization': 'Token 0d3b9917be6a263b12798a083cc4566d9505f591',
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      };

      var regions = ['nz', 'br'];

      var request = await http
          .post(postUri,
              body: json.encode({
                'regions': regions,
                'upload': imageBase64,
              }) /*image.readAsBytesSync()*/,
              headers: postHeaders)
          .timeout(const Duration(seconds: 30));

      print(request.body);
      var recognizedPlate = jsonDecode(request.body)['results'][0]['plate'];

      if (recognizedPlate == null) {
        return Left(imageBase64);
      } else {
        return Right(recognizedPlate);
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      return Left(imageBase64);
    }
  }
}
