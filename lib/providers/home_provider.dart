import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_upload/repositories/file_upload_repo.dart';
import 'package:image_upload/constants/toast.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeProvider extends ChangeNotifier {
  final FileUploadRepo fileUploadAPI = FileUploadRepo();
  bool _isLoading = false;
  String _mediaUrl = "";

  String get mediaUrl => _mediaUrl;
  set mediaUrl(String value) {
    _mediaUrl = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      isLoading = true;
      final pickedImage = await ImagePicker().pickImage(source: source);
      mediaUrl = pickedImage!.path;
      uploadImage(mediaUrl);
      isLoading = false;
    } catch (e) {
      isLoading = false;
      showToast("Image not picked");
    }
  }

  Future uploadImage(mediaUrl) async {
    await fileUploadAPI.uploadImage(mediaUrl);
  }
}
