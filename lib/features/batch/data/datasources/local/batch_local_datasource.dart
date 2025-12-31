import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/services/hive/hive_service.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_hive_model.dart';

final batchLocalDataSourceProvider = Provider<BatchLocalDatasource>((ref){
  return BatchLocalDatasource(HiveService: ref.read(hiveServiceProvider));
});

class BatchLocalDatasource implements IBatchDataSource {
  final HiveService _hiveService;

  BatchLocalDatasource({required HiveService HiveService})
    : _hiveService = HiveService;

  @override
  Future<bool> createBatch(BatchHiveModel entity) async {
    try {
      await _hiveService.createBatch(entity);
      return true;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<bool> deleteBatch(BatchHiveModel batchId) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<List<BatchHiveModel>> getAllBatches() async {
    try {
      return _hiveService.getAllBatches();
    } catch (err) {
      return [];
    }
  }

  @override
  Future<List<BatchHiveModel>> getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBatch(BatchHiveModel model) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
