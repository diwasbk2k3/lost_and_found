import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/services/connectivity/network_info.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/datasources/local/batch_local_datasource.dart';
import 'package:lost_n_found/features/batch/data/datasources/remote/batch_remote_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

final batchRepositoryProvider = Provider<IBatchRepository>((ref) {
  final batchLocalDatasource = ref.read(batchLocalDataSourceProvider);
  final batchRemoteDatasource = ref.read(batchRemoteProvider);
  final networkInfo = ref.read(networkInfoProvider);

  return BatchRepository(
    batchDataSource: batchLocalDatasource,
    batchRemoteDatasource: batchRemoteDatasource,
    networkInfo: networkInfo,
  );
});

class BatchRepository implements IBatchRepository {
  final IBatchLocalDataSource _batchLocalDataSource;
  final IBatchRemoteDataSource _batchRemoteDataSource;
  final NetworkInfo _networkInfo;

  BatchRepository({
    required IBatchLocalDataSource batchDataSource,
    required IBatchRemoteDataSource batchRemoteDatasource,
    required NetworkInfo networkInfo,
  }) : _batchLocalDataSource = batchDataSource,
       _batchRemoteDataSource = batchRemoteDatasource,
       _networkInfo = networkInfo;

  @override
  Future<Either<Failure, bool>> createBatch(BatchEntity entity) async {
    try {
      // entity lai model ma convert garnu parcha
      final model = BatchHiveModel.fromEntity(entity);
      final result = await _batchLocalDataSource.createBatch(model);
      if (result) {
        return Right(true);
      } else {
        return Left(LocalDatabaseFailure(message: "Failed to create batch"));
      }
    } catch (err) {
      return Left(LocalDatabaseFailure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteBatch(String batchId) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getAllBatches() async {
    // internet cha ki chaina
    if (await _networkInfo.isConnected) {
      try {
        // api model lai capture garyu
        final apiModels = await _batchRemoteDataSource.getAllBatches();
        // convert to entity
        final result = BatchApiModel.toEntityList(apiModels);
        return Right(result);
      } on DioException catch (e) {
        return Left(
          ApiFailure(
            statusCode: e.response?.statusCode,
            message: e.response?.data['message'] ?? 'Failed to fetch batches',
          ),
        );
      }
    } else {
      try {
        final models = await _batchLocalDataSource.getAllBatches();
        final entities = BatchHiveModel.toEntityList(models);
        return Right(entities);
      } catch (e) {
        return Left(LocalDatabaseFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, BatchEntity>> getBatchById() {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateBatch(BatchEntity entity) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
