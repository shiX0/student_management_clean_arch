import 'package:student_management_starter/app/navigator/navigator.dart';
import 'package:student_management_starter/features/course/presentation/view/course_view.dart';

mixin CourseNavigator {
  openCourseView() {
    NavigateRoute.pushRoute(const CourseView());
  }
}
