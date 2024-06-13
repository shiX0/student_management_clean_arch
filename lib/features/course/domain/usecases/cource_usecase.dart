import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/error/failure.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/repository/course_repository.dart';

final courceUsecaseProvider = Provider<CourceUsecase>((ref) =>
    CourceUsecase(courseRepository: ref.read(courseRepositoryProvider)));

class CourceUsecase {
  final ICourseRepository courseRepository;
  CourceUsecase({required this.courseRepository});
  Future<Either<Faliure, bool>> addCourse(CourseEntity course) {
    return courseRepository.addCourse(course);
  }

  Future<Either<Faliure, List<CourseEntity>>> getAllCourses() {
    return courseRepository.getAllCourses();
  }
}
