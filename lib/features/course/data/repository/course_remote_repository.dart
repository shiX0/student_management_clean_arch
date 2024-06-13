import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/features/course/data/data_source/remote/course_remote_data_source.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/course_repository.dart';

final courseRemoteRepositoryProvider = Provider<ICourseRepository>((ref) {
  return CourseRemoteRepository(
      courseRemoteDataSource: ref.read(courseRemoteDataSourceProvider));
});

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource courseRemoteDataSource;
  CourseRemoteRepository({required this.courseRemoteDataSource});
  @override
  Future<Either<Faliure, bool>> addCourse(CourseEntity course) {
    return courseRemoteDataSource.addCourse(course);
  }

  @override
  Future<Either<Faliure, List<CourseEntity>>> getAllCourses() {
    return courseRemoteDataSource.getAllCourses();
  }
}
