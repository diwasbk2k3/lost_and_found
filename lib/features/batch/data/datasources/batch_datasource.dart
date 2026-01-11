import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';

abstract interface class IBatchLocalDataSource {
  Future<List<BatchHiveModel>> getAllBatches();
  Future<List<BatchHiveModel>> getBatchById(String batchId);
  Future<bool> createBatch(BatchHiveModel batch);
  Future<bool> updateBatch(BatchHiveModel batch);
  Future<bool> deleteBatch(BatchHiveModel batchId);
}

abstract interface class IBatchRemoteDataSource {
  Future<List<BatchApiModel>> getAllBatches();
  Future<List<BatchApiModel>> getBatchById(String batchId);
  Future<bool> createBatch(BatchApiModel batch);
  Future<bool> updateBatch(BatchApiModel batch);
  Future<bool> deleteBatch(BatchApiModel batchId);
}