import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecase/app_usecase.dart';
import 'package:lost_n_found/features/item/data/datasources/remote/item_remote_datasource.dart';
import 'package:lost_n_found/features/item/domain/repositories/item_repository.dart';

// Provider
final uploadPhotoUsecaseProvider = Provider<UploadPhotoUseCase>((ref) {
  final repository = ref.read(itemRemoteServiceProvider);
  return UploadPhotoUseCase(repository: repository);
});

class UploadPhotoUseCase implements UseCaseWithParams<String, File> {
  final IItemRepository _repository;
  UploadPhotoUseCase({required IItemRepository repository})
    : _repository = repository;

  @override
  Future<Either<Failure, String>> call(File params) {
    return _repository.uploadImage(params);
  }
}
