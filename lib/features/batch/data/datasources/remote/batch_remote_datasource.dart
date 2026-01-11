import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lost_n_found/core/api/api_client.dart';
import 'package:lost_n_found/core/api/api_endpoints.dart';
import 'package:lost_n_found/features/batch/data/datasources/batch_datasource.dart';
import 'package:lost_n_found/features/batch/data/models/batch_api_model.dart';

// Provider
final batchRemoteProvider = Provider<IBatchRemoteDataSource>((ref) {
  return BatchRemoteDatasource(apiClient: ref.read(apiClientProvider));
});

class BatchRemoteDatasource implements IBatchRemoteDataSource {
  final ApiClient _apiClient;

  BatchRemoteDatasource({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<bool> createBatch(BatchApiModel batch) async {
    final response = await _apiClient.post(ApiEndpoints.batches);
    return response.data["success"] == true;
  }

  @override
  Future<bool> deleteBatch(batchId) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<List<BatchApiModel>> getAllBatches() async {
    final response = await _apiClient.get(ApiEndpoints.batches);
    final data = response.data["data"] as List;
    return data.map((json) => BatchApiModel.fromJson(json)).toList();
  }

  @override
  getBatchById(String batchId) {
    // TODO: implement getBatchById
    throw UnimplementedError();
  }

  @override
  Future<bool> updateBatch(batch) {
    // TODO: implement updateBatch
    throw UnimplementedError();
  }
}
