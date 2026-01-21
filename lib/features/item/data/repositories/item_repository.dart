import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/services/connectivity/network_info.dart';
import 'package:lost_n_found/features/item/data/datasources/remote/item_remote_datasource.dart';
import 'package:lost_n_found/features/item/domain/repositories/item_repository.dart';

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  final itemRemoteDataSource = ref.read(itemRemoteServiceProvider);
  final networkInfo = ref.read(networkInfoProvider);

  return ItemRepository(
    networkInfo: networkInfo,
    itemRemoteDataSource: itemRemoteDataSource,
  );
});


class ItemRepository implements IItemRepository {
  final NetworkInfo _networkInfo;
  final ItemRemoteDataSource _itemRemoteDataSource;

  ItemRepository({
    required NetworkInfo networkInfo,
    required ItemRemoteDataSource itemRemoteDataSource,
  })  : _networkInfo = networkInfo,
        _itemRemoteDataSource = itemRemoteDataSource;

  @override
  Future<Either<Failure, String>> uploadImage(File image) async {
    if (await _networkInfo.isConnected) {
      try {
        final fileName = await _itemRemoteDataSource.uploadImage(image);
        return right(fileName);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(ApiFailure(message: "No internet connection"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadVideo(File video) async {
    if (await _networkInfo.isConnected) {
      try {
        final fileName = await _itemRemoteDataSource.uploadVideo(video);
        return right(fileName);
      } catch (e) {
        return Left(ApiFailure(message: e.toString()));
      }
    } else {
      return Left(ApiFailure(message: "No internet connection"));
    }
  }
}
