import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  static const String _cloudName = 'dck9ymwb';
  static const String _uploadPreset = 'nearshop';

  static final Dio _dio = Dio();

  static Future<String?> uploadImage({
    required XFile image,
    required String folder,
  }) async {
    try {
      final String fileName = image.name;

      final FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path, filename: fileName),
        'upload_preset': _uploadPreset,
        'folder': folder,
      });

      final Response<dynamic> response = await _dio.post(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic data = response.data;

        if (data is Map<String, dynamic>) {
          return data['secure_url']?.toString();
        }
      }

      return null;
    } on DioException {
      return null;
    } catch (e) {
      return null;
    }
  }
}
