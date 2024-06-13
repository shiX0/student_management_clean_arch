import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchLocalDatasourceProvider = Provider((ref) => BatchLocalDatasource(
    batchHiveModel:
        ref.read(batchHiveModelProvider), //passing batch hive model provider
    hiveService: ref.read(hiveServiceProvider) //passing batch hive model object
    ));

class BatchLocalDatasource {
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDatasource({
    required this.batchHiveModel,
    required this.hiveService,
  });

  Future<Either<Faliure, bool>> addBatch(BatchEntity batch) async {
    try {
      final hiveBatch = batchHiveModel.fromEntity(batch);
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    } catch (e) {
      return Left(Faliure(error: e.toString()));
    }
  }

  Future<Either<Faliure, List<BatchEntity>>> getAllBatches() async {
    try {
      final hiveBatches = await hiveService.getAllBatches();
      final batches = batchHiveModel.toEntityList(hiveBatches);
      return Right(batches);
    } catch (e) {
      return Left(Faliure(error: e.toString()));
    }
  }
}
