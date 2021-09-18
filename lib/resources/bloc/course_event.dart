part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class GetCourseCategoryList extends CourseEvent {
  final int parent;
  const GetCourseCategoryList(this.parent);

  @override
  List<Object> get props => [];
}

class GetCoursesByCategory extends CourseEvent {
  final int id;
  const GetCoursesByCategory(this.id);

  @override
  List<Object> get props => [];
}