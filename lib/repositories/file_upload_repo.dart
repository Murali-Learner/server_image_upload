import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:image_upload/constants/toast.dart';

class FileUploadRepo {
  Future uploadImage(String url) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://aws143.arnavgoyal4.repl.co/upload"),
      );
      var image = await http.MultipartFile.fromPath(
        "files[]",
        url,
      );
      request.files.add(image);
      var response = await request.send();
      if (response.statusCode == 201) {
        showToast("Image successfully uploaded to the sever.");
      } else {
        showToast("Something went wrong, try again.");
      }
    } catch (e) {
      log("---$e");
    }
  }
}
