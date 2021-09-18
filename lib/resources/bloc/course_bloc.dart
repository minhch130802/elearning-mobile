import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:elearning_project/resources/repositories/course_repository.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial());

  final CourseRepository _courseRepository = CourseRepository();

  @override
  CourseState get initState => CourseInitial();

  @override
  Stream<CourseState> mapEventToState(
    CourseEvent event,
  ) async* {
    if(event is GetCourseCategoryList) {
      try {
        yield CourseLoading();
        final mList = await _courseRepository.fetchCourseCategories(event.parent);
        yield CourseLoaded(mList);
      } catch(_) {
        yield CourseError("Failed to fetch data. is your device online?");
      }
    }

    if(event is GetCoursesByCategory) {
      try {
        yield CourseLoading();
        final mList = await _courseRepository.getCourseByCategory(event.id);
        yield CourseLoaded(mList);
      } catch(_) {
        yield CourseError("Failed to fetch data. is your device online?");
      }
    }
  }
}
