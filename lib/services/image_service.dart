import 'dart:io';

import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static Future<String?> camera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      final fileTemp = File(pickedImage.path);
      final image = decodeImage(fileTemp.readAsBytesSync());
      final resizedImage = copyResize(image!, width: 600, height: 800);
      final tempDir = await getTemporaryDirectory();
      final fileResult = File('${tempDir.path}/${pickedImage.name}')
        ..writeAsBytesSync(encodeJpg(resizedImage, quality: 70));

      final imagePath = fileResult.path;
      return imagePath;
    }
    return null;
  }

  static Future<void> gallery() async {}
}
