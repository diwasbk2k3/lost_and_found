import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/api/api_client.dart';
import 'package:lost_n_found/core/api/api_endpoints.dart';
import 'package:lost_n_found/core/services/storage/token_service.dart';
import 'package:lost_n_found/features/item/data/datasources/item_datasource.dart';

// Provider
final itemRemoteServiceProvider = Provider<IItemRemoteDataSource>((ref) {
  return ItemRemoteDataSource(
    apiClient: ref.read(apiClientProvider),
    tokenService: ref.read(tokenServiceProvider),
  );
});

class ItemRemoteDataSource implements IItemRemoteDataSource {
  final ApiClient _apiClient;
  final TokenService _tokenService;

  ItemRemoteDataSource({
    required ApiClient apiClient,
    required TokenService tokenService,
  }) : _apiClient = apiClient,
       _tokenService = tokenService;

  @override
  Future<String> uploadImage(File image) {
    // C:Desktop/images/abc.png
    final fileName = image.path.split("/").last;
    final formData = FormData.fromMap({
      'itemPhoto': MultipartFile.fromFile(image.path, filename: fileName),
    });

    // get token from the token service
    final token = _tokenService.getToken();

    final response = _apiClient.uploadFile(
      ApiEndpoints.itemUploadPhoto,
      formData: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data["success"];
  }

  @override
  Future<String> uploadVideo(File video) {
    // C:Desktop/images/abc.mp4
    final fileName = video.path.split("/").last;
    final formData = FormData.fromMap({
      'itemVideo': MultipartFile.fromFile(video.path, filename: fileName),
    });

    // get token from the token service
    final token = _tokenService.getToken();

    final response = _apiClient.uploadFile(
      ApiEndpoints.itemUploadVideo,
      formData: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data["success"];
  }
}
