import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchApiModelProvider = Provider((ref) => BatchApiModel.empty());

@JsonSerializable()
class BatchApiModel {
  @JsonKey(name: '_id')
  final String batchId;

  final String batchName;

  BatchApiModel({required this.batchId, required this.batchName});

  BatchApiModel.empty()
      : batchId = '',
        batchName = '';

  factory BatchApiModel.fromJson(Map<String, dynamic> json) {
    return BatchApiModel(batchId: json['_id'], batchName: json['batchName']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': batchId,
      'batchName': batchName,
    };
  }

  BatchEntity toEntity() => BatchEntity(batchId: batchId, batchName: batchName);

  BatchApiModel fromEntity(BatchEntity entity) =>
      BatchApiModel(batchId: entity.batchId ??'', batchName: entity.batchName!);

  List<BatchEntity> toEntityList(List<BatchApiModel> model) =>
      model.map((map) => map.toEntity()).toList();
}
