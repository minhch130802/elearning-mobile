part of 'course_bloc.dart';

abstract class CourseState extends Equatable {
  const CourseState();
}

class CourseInitial extends CourseState {
  const CourseInitial();

  @override
  List<Object> get props => [];
}

class CourseLoading extends CourseState {
  const CourseLoading();

  @override
  List<Object> get props => [];
}

class CourseHomeLoaded extends CourseState {
  final dynamic data;
  const CourseHomeLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseCategoriesLoaded extends CourseState {
  final dynamic data;
  const CourseCategoriesLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseCoursesLoaded extends CourseState {
  final dynamic data;
  const CourseCoursesLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseContentLoaded extends CourseState {
  final dynamic data;
  const CourseContentLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseEnrollLoaded extends CourseState {
  final dynamic data;
  const CourseEnrollLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);

  @override
  List<Object> get props => [message];
}

class CourseNavigate extends CourseState {
  const CourseNavigate(this.id, this.name);
  final String name;
  final int id;

  @override
  List<Object> get props => [id, name];
}

class CourseEnrolled extends CourseState {
  const CourseEnrolled(this.enrolled);
  final bool enrolled;

  @override
  List<Object> get props => [enrolled];
}