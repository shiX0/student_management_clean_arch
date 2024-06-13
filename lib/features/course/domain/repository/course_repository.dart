import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/features/course/data/repository/course_local_repository.dart';
import 'package:student_management_starter/features/course/data/repository/course_remote_repository.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseRepositoryProvider = Provider<ICourseRepository>((ref) {
  return ref.read(courseRemoteRepositoryProvider);
});

abstract class ICourseRepository {
  Future<Either<Faliure, bool>> addCourse(CourseEntity course);
  Future<Either<Faliure, List<CourseEntity>>> getAllCourses();
}
