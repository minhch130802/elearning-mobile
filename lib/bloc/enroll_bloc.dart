import 'package:bloc/bloc.dart';
import 'package:elearning_project/models/enrol.dart';
import 'package:elearning_project/repositories/enroll_repository.dart';
import 'package:equatable/equatable.dart';

part 'enroll_event.dart';
part 'enroll_state.dart';

class EnrollBloc extends Bloc<EnrollEvent, EnrollState> {
  EnrollBloc() : super(EnrollInitial());

  final EnrollRepository _enrollRepository = EnrollRepository();

  EnrollState get initState => EnrollInitial();

  @override
  Stream<EnrollState> mapEventToState(
      EnrollEvent event,
  ) async* {
    if(event is GetEnrollMethod) {
      try {
        yield EnrollLoading();
        final data = await _enrollRepository.fetchCourseEnrolMethod(event.id);
        yield EnrollMethodLoaded(data);
      } catch (ex) {
        yield EnrollError(ex.toString());
      }
    }

    if(event is GetEnrollMethodInfo) {
      try {
        yield EnrollLoading();
        final methodData = await _enrollRepository.fetchCourseEnrolMethod(event.id);
        final infoData = await _enrollRepository.fetchCourseEnrolMethodInfo(methodData.id!);
        yield EnrollMethodInfoLoaded(infoData);
      } catch (ex) {
        yield EnrollError(ex.toString());
      }
    }
  }
}
