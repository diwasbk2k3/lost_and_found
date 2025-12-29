import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class BatchRepository implements IBatchRepository {
  final IBatchDataSource _dataSource;

  BatchRepository({required IBatchDataSource datasource})
    : _dataSource = datasource;

  @override
  Future<Either<Failure, bool>> createBatch(BatchEntity entity) async {
    try {
      // entity lai model ma convert garnu parcha
      final model = BatchHiveModel.fromEntity(entity);
      final result = await _dataSource.createBatch(model);
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
    try {
      final models = await _dataSource.getAllBatches();
      final entities = BatchHiveModel.toEntityList(models);
      return Right(entities);
    } catch (err) {
      return Left(LocalDatabaseFailure(message: err.toString()));
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
