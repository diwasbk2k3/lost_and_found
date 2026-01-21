import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';

abstract interface class IItemRepository {
  // Future<Either<Failure, List<ItemEntity>>> getAllItems();
  // Future<Either<Failure, List<ItemEntity>>> getItemByUser(String userId);

  //image/video upload
  Future<Either<Failure, String>> uploadImage(File image);
  Future<Either<Failure, String>> uploadVideo(File video);
}
