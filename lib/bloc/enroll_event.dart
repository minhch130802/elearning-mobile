part of 'enroll_bloc.dart';

abstract class EnrollEvent extends Equatable {
  const EnrollEvent();

  @override
  List<Object> get props => [];
}

class GetEnrollMethod extends EnrollEvent {
  final int id;
  const GetEnrollMethod(this.id);

  @override
  List<Object> get props => [];
}

class GetEnrollMethodInfo extends EnrollEvent {
  final int id;
  const GetEnrollMethodInfo(this.id);

  @override
  List<Object> get props => [];
}
