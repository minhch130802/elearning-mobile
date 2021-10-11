import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:elearning_project/repositories/course_repository.dart';
import 'package:elearning_project/repositories/enroll_repository.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial());

  final CourseRepository _courseRepository = CourseRepository();
  final EnrollRepository _enrollRepository = EnrollRepository();

  CourseState get initState => CourseInitial();

  @override
  Stream<CourseState> mapEventToState(
    CourseEvent event,
  ) async* {
    if (event is GetHomeCategoryList) {
      try {
        yield CourseLoading();
        final data =
            await _courseRepository.fetchCourseCategories(event.parent);

        if (data.length == 0) {
          yield CourseNavigate(event.parent, event.name);
        } else {
          yield CourseHomeLoaded(data);
        }
      } catch (ex) {
        yield CourseError(ex.toString());
      }
    }

    if (event is GetCourseCategoryList) {
      try {
        yield CourseLoading();
        final data =
        await _courseRepository.fetchCourseCategories(event.parent);

        if (data.length == 0) {
          yield CourseNavigate(event.parent, event.name);
        } else {
          yield CourseCategoriesLoaded(data);
        }
      } catch (ex) {
        yield CourseError(ex.toString());
      }
    }

    if (event is GetCoursesByCategory) {
      try {
        yield CourseLoading();
        final data = await _courseRepository.fetchCoursesByCategory(event.id);
        yield CourseCoursesLoaded(data);
      } catch (ex) {
        yield CourseError(ex.toString());
      }
    }

    if(event is GetCourseContent) {
      try {
        yield CourseLoading();
        final data = await _courseRepository.fetchCourseContent(event.id);
        yield CourseContentLoaded(data);
      } catch (ex) {
        if(ex.toString().contains('errorcoursecontextnotvalid')) {
          yield CourseEnrolled(false);
        } else {
          yield CourseError(ex.toString());
        }
      }
    }

    if(event is SelfEnrollment) {
      try {
        yield CourseLoading();
        await _enrollRepository.selfEnrollment(event.id, event.password);
        yield CourseEnrolled(true);
      } catch (ex) {
        yield CourseError(ex.toString());
      }
    }

    if(event is SetCourseEnrolled) {
      yield CourseEnrolled(event.enrolled);
    }
  }
}
