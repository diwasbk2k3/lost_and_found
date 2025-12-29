import 'package:lost_n_found/features/auth/data/models/batch_hive_model.dart';

abstract interface class IBatchDataSource {
  Future<List<BatchHiveModel>> getAllBatches();
  Future<List<BatchHiveModel>> getBatchById(String batchId);
  Future<bool> createBatch(BatchHiveModel model);
  Future<bool> updateBatch(BatchHiveModel model);
  Future<bool> deleteBatch(BatchHiveModel batchId);
}
