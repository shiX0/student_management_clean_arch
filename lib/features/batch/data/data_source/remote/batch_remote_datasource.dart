import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:student_management_starter/app/constants/api_endpoint.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/core/networking/remote/http_service.dart';
import 'package:student_management_starter/features/batch/data/dto/get_all_batch_dto.dart';
import 'package:student_management_starter/features/batch/data/model/batch_api_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchRemoteDatasourceProvider = Provider<BatchRemoteDatasource>((ref) {
  return BatchRemoteDatasource(
      dio: ref.read(httpServiceProvider),
      batchApiModel: ref.read(batchApiModelProvider));
});

class BatchRemoteDatasource {
  final Dio dio;
  final BatchApiModel batchApiModel;

  BatchRemoteDatasource({required this.dio, required this.batchApiModel});

  Future<Either<Faliure, bool>> addBatch(BatchEntity entity) async {
    try {
      var response = await dio.post(ApiEndpoints.createBatch,
          data: batchApiModel.fromEntity(entity).toJson());

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(Faliure(
            error: response.data['message'],
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Faliure(
        error: e.message.toString(),
      ));
    }
  }

  Future<Either<Faliure, List<BatchEntity>>> getAllBatches() async {
    try {
      var response = await dio.get(ApiEndpoints.getAllBatch);
      // debugPrint(response.data);
      if (response.statusCode == 200) {
        GetAllBatchDto batchDto = GetAllBatchDto.fromJson(response.data);
        return Right(batchApiModel.toEntityList(batchDto.data));
      } else {
        return Left(Faliure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Faliure(error: e.error.toString()));
    }
  }
}
