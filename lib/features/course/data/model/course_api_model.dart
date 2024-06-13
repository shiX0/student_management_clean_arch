import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';

final courseApiModelProvider =
    Provider<CourseApiModel>((ref) => CourseApiModel.empty());

@JsonSerializable()
class CourseApiModel {
  @JsonKey(name: '_id')
  final String courseId;
  final String courseName;

  CourseApiModel({required this.courseId, required this.courseName});
  CourseApiModel.empty()
      : courseId = '',
        courseName = '';

  //the data received from backend is converted to dart
  factory CourseApiModel.fromJson(Map<String, dynamic> json) {
    return CourseApiModel(
      courseId: json['_id'],
      courseName: json['courseName'],
    );
  }

  //again the data is converted to Json to send back to the database
  Map<String, dynamic> toJson() {
    return {'_id': courseId, 'courseName': courseName};
  }

  CourseEntity toEntity() =>
      CourseEntity(courseId: courseId, courseName: courseName);

  CourseApiModel fromEntity(CourseEntity entity) => CourseApiModel(
      courseId: entity.courseId ?? '', courseName: entity.courseName);

  List<CourseEntity> toEntityList(List<CourseApiModel> model) =>
      model.map((mod) => mod.toEntity()).toList();
}
