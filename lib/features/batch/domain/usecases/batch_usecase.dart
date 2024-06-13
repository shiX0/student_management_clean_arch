import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_repository.dart';

final batchUsecaseProvider = Provider<BatchUsecase>(
    (ref) => BatchUsecase(batchRepository: ref.read(batchRepositoryProvider)));

class BatchUsecase {
  final IBatchRepository batchRepository;
  BatchUsecase({required this.batchRepository});

  Future<Either<Faliure, bool>> addBatch(BatchEntity batch) {
    return batchRepository.addBatch(batch);
  }

  Future<Either<Faliure, List<BatchEntity>>> getAllBatches() {
    return batchRepository.getAllBatches();
  }
}
