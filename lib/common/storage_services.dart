import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  static const String _cloudName = 'dck9ymyvb';
  static const String _uploadPreset = 'nearshop';

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );

  /// Last upload error (debugging ke liye). Success par empty ho jata hai.
  static String lastError = '';

  static Future<String?> uploadImage({
    required XFile image,
    required String folder,
  }) async {
    lastError = '';

    try {
      // Bytes se upload: mobile aur web dono par chalta hai
      final bytes = await image.readAsBytes();

      final FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          bytes,
          filename: image.name.isNotEmpty ? image.name : 'product.jpg',
        ),
        'upload_preset': _uploadPreset,
        // Folder abhi request mein nahi bhej rahe, preset ka
        // Asset folder (nearshop) use hoga.
      });

      final Response<dynamic> response = await _dio.post(
        'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
        data: formData,
      );

      debugPrint('Cloudinary status: ${response.statusCode}');
      debugPrint('Cloudinary response: ${response.data}');

      final dynamic data = response.data;

      if (data is Map && data['secure_url'] != null) {
        return data['secure_url'].toString();
      }

      lastError = 'Response mein secure_url nahi mila';
      debugPrint('Cloudinary: $lastError');
      return null;
    } on DioException catch (e) {
      final dynamic body = e.response?.data;

      // Cloudinary error aise aata hai: {"error": {"message": "..."}}
      String message = e.message ?? 'Unknown error';
      if (body is Map && body['error'] is Map) {
        message = body['error']['message'].toString();
      } else if (body != null) {
        message = body.toString();
      }

      lastError = '${e.response?.statusCode ?? e.type.name}: $message';

      debugPrint('Cloudinary HTTP status: ${e.response?.statusCode}');
      debugPrint('Cloudinary error response: ${e.response?.data}');
      debugPrint('Cloudinary error type: ${e.type}');
      debugPrint('Cloudinary error message: ${e.message}');

      return null;
    } catch (e, stackTrace) {
      lastError = e.toString();
      debugPrint('Cloudinary unexpected error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }
}
