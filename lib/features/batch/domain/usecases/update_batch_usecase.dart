import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lost_n_found/core/error/failures.dart';
import 'package:lost_n_found/core/usecase/app_usecase.dart';
import 'package:lost_n_found/features/batch/domain/entities/batch_entity.dart';
import 'package:lost_n_found/features/batch/domain/repositories/batch_repository.dart';

class UpdateBatchUsecaseParams extends Equatable {
  final String batchId;
  final String batchName;
  final String? status;

  const UpdateBatchUsecaseParams({
    required this.batchId,
    required this.batchName,
    this.status,
  });

  @override
  List<Object?> get props => [batchId, batchName, status];
}

// Usecase
class UpdateBatchUsecase
    implements UseCaseWithParams<bool, UpdateBatchUsecaseParams> {
  final IBatchRepository _batchRepository;

  UpdateBatchUsecase({required IBatchRepository batchRepository})
    : _batchRepository = batchRepository;

  @override
  Future<Either<Failure, bool>> createBatch(UpdateBatchUsecaseParams params) {
    BatchEntity batchEntity = BatchEntity(
      batchId: params.batchId,
      batchName: params.batchName,
      status: params.status,
    );
    return _batchRepository.updateBatch(batchEntity);
  }
}
