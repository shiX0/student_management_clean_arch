import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management_starter/app/constants/hive_table_constant.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

part 'course_hive_model.g.dart';

final courseHiveModelProvider =
    Provider<CourseHiveModel>((ref) => CourseHiveModel.empty());

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel {
  @HiveField(0)
  final String? courseId;
  @HiveField(1)
  final String courseName;

  CourseHiveModel({required this.courseName, String? courseId})
      : courseId = courseId ?? const Uuid().v4();

  CourseHiveModel.empty()
      : courseId = '',
        courseName = "";

  CourseEntity toEntity() {
    return CourseEntity(courseName: courseName, courseId: courseId);
  }

  CourseHiveModel fromEntity(CourseEntity entity) {
    return CourseHiveModel(
        courseName: entity.courseName, courseId: entity.courseId);
  }

  List<CourseEntity> toCourseEntityList(List<CourseHiveModel> lst) {
    return lst.map((model) => model.toEntity()).toList();
  }
}
