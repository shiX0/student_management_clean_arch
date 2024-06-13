import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/features/course/domain/entity/course_entity.dart';
import 'package:student_management_starter/features/course/presentation/viewmodel/course_view_model.dart';

class CourseView extends ConsumerStatefulWidget {
  const CourseView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseViewState();
}

class _CourseViewState extends ConsumerState<CourseView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController courceController = TextEditingController();
    var courseState = ref.watch(courseViewModelProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Add Course"),
            TextFormField(
              controller: courceController,
              decoration: const InputDecoration(
                labelText: 'Enter a Course',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      ref.read(courseViewModelProvider.notifier).addCourse(
                          CourseEntity(courseName: courceController.text));
                    },
                    child: const Text('add course'))),
            const Text("Course List"),
            if (courseState.isLoading) ...{
              const Center(
                child: CircularProgressIndicator(),
              )
            } else if (courseState.error != null) ...{
              Text(courseState.error.toString())
            } else if (courseState.lst.isEmpty) ...{
              const Text("NO COURSES")
            } else ...{
              Expanded(
                child: ListView.builder(
                  itemCount: courseState.lst.length,
                  itemBuilder: (context, index) {
                    var courses = courseState.lst[index];
                    return ListTile(
                      leading: IconButton(
                        icon: const Icon(Icons.group_outlined),
                        onPressed: () {},
                      ),
                      title: Text(courses.courseName),
                      subtitle: Text(courses.courseId ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
              )
            }
          ],
        ),
      ),
    );
  }
}
