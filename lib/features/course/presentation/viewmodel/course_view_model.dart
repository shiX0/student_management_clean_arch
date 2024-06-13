import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/common/my_snackbar.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/domain/usecases/cource_usecase.dart';
import 'package:student_management_starter/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courceUsecaseProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  CourseViewModel(this.courceUsecase) : super(CourseState.initial()) {
    getAllCourses();
  }
  final CourceUsecase courceUsecase;

  addCourse(CourseEntity course) async {
    state = state.copyWith(isLoading: true);
    var data = await courceUsecase.addCourse(course);
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackbar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, error: null);
      showMySnackbar(message: "course Added Sucessfully!");
    });
    getAllCourses();
  }

  getAllCourses() async {
    state = state.copyWith(isLoading: true);
    var data = await courceUsecase.getAllCourses();
    data.fold((l) {
      state = state.copyWith(isLoading: false, error: l.error);
      showMySnackbar(message: l.error, color: Colors.red[800]);
    }, (r) {
      state = state.copyWith(isLoading: false, lst: r, error: null);
    });
  }
}
