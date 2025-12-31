import 'package:dartz/dartz.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecase/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class GetAllBatchUsecase implements UseCaseWithoutParams<List<BatchEntity>> {
  final IBatchRepository _batchRepository;

  GetAllBatchUsecase({required IBatchRepository batchRepository})
    : _batchRepository = batchRepository;

  @override
  Future<Either<Failure, List<BatchEntity>>> createBatch() {
    return _batchRepository.getAllBatches();
  }
}
