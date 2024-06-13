import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/course/data/model/course_hive_model.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseLocalDatasourceProvider = Provider(
  (ref) => CourseLocalDatasource(
      courseHiveModel: ref.read(courseHiveModelProvider),
      hiveService: ref.read(hiveServiceProvider)),
);

class CourseLocalDatasource {
  final HiveService hiveService;
  final CourseHiveModel courseHiveModel;

  CourseLocalDatasource(
      {required this.courseHiveModel, required this.hiveService});

  Future<Either<Faliure, bool>> addCourse(CourseEntity course) async {
    try {
      final hiveCourse = courseHiveModel.fromEntity(course);
      await hiveService.addCourse(hiveCourse);
      return const Right(true);
    } catch (e) {
      return Left(Faliure(error: e.toString()));
    }
  }

  Future<Either<Faliure, List<CourseEntity>>> getAllCourses() async {
    try {
      final hiveCourse = await hiveService.getAllCourse();
      final batches = courseHiveModel.toCourseEntityList(hiveCourse);
      return Right(batches);
    } catch (e) {
      return Left(Faliure(error: e.toString()));
    }
  }
}
