import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management_starter/app/constants/hive_table_constant.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';
import 'package:uuid/uuid.dart';

part 'batch_hive_model.g.dart';
// Dart Run build_runner build -d (-d delete condflits)


final batchHiveModelProvider = Provider((ref) => BatchHiveModel.empty());

// Creating a hive adapter
@HiveType(typeId: HiveTableConstant.batchTableId)
class BatchHiveModel {
  @HiveField(0)
  final String? batchId;
  @HiveField(1)
  final String batchName;

  BatchHiveModel({String? batchId, required this.batchName})
      : batchId = batchId ?? const Uuid().v4();

  BatchHiveModel.empty()
      : batchId = '',
        batchName = '';

  BatchEntity toEntity() => BatchEntity(batchId: batchId, batchName: batchName);

  BatchHiveModel fromEntity(BatchEntity entity) =>
      BatchHiveModel(batchId: entity.batchId, batchName: entity.batchName!);

  List<BatchEntity> toEntityList(List<BatchHiveModel> model) =>
      model.map((mod) => mod.toEntity()).toList();
}
