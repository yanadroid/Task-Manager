import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GetImagePicker {

  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }

    return null;
  }
}
