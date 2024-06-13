import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final String? courseId;
  final String courseName;

  const CourseEntity({required this.courseName, this.courseId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
