import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';


class CourseState {
  final List<CourseEntity> lst;
  final bool isLoading;
  final String? error;

  CourseState({required this.lst, required this.isLoading, this.error});

  factory CourseState.initial() {
    return CourseState(lst: [], isLoading: false, error: null);
  }

  CourseState copyWith(
      {List<CourseEntity>? lst, bool? isLoading, String? error}) {
    return CourseState(
        lst: lst ?? this.lst,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error);
  }
}
