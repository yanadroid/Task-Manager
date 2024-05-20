import 'dart:io';

import 'package:file_picker/file_picker.dart';

class GetFilePicker {

  static Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if (result != null) {
      return File(result.files.single.path!);
    }
    return null;
  }
}
