import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/features/batch/data/data_source/remote/batch_remote_datasource.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management_starter/features/batch/domain/repository/batch_repository.dart';

final batchRemoteRepositoryProvider = Provider<IBatchRepository>((ref) =>
    BatchRemoteRepository(
        batchRemoteDatasource: ref.watch(batchRemoteDatasourceProvider)));

class BatchRemoteRepository implements IBatchRepository {
  final BatchRemoteDatasource batchRemoteDatasource;
  BatchRemoteRepository({required this.batchRemoteDatasource});

  @override
  Future<Either<Faliure, bool>> addBatch(BatchEntity batch) {
    return batchRemoteDatasource.addBatch(batch);
  }

  @override
  Future<Either<Faliure, List<BatchEntity>>> getAllBatches() {
    return batchRemoteDatasource.getAllBatches();
  }
}
