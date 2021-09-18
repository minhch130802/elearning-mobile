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

class CourseLoaded extends CourseState {
  final dynamic data;
  const CourseLoaded(this.data);

  @override
  List<dynamic> get props => [data];
}

class CourseError extends CourseState {
  final String message;
  const CourseError(this.message);

  @override
  List<Object> get props => [message];
}
