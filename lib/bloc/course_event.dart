part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();
}

class GetHomeCategoryList extends CourseEvent {
  final int parent;
  final String name;
  const GetHomeCategoryList(this.parent, this.name);

  @override
  List<Object> get props => [];
}

class GetCourseCategoryList extends CourseEvent {
  final int parent;
  final String name;
  const GetCourseCategoryList(this.parent, this.name);

  @override
  List<Object> get props => [];
}

class GetCoursesByCategory extends CourseEvent {
  final int id;
  const GetCoursesByCategory(this.id);

  @override
  List<Object> get props => [];
}

class GetCourseContent extends CourseEvent {
  final int id;
  const GetCourseContent(this.id);

  @override
  List<Object> get props => [];
}

class SelfEnrollment extends CourseEvent {
  final int id;
  final String password;
  const SelfEnrollment(this.id, this.password);

  @override
  List<Object> get props => [];
}

class SetCourseEnrolled extends CourseEvent {
  final bool enrolled;
  const SetCourseEnrolled(this.enrolled);

  @override
  List<Object> get props => [];
}