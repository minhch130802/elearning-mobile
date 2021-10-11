part of 'enroll_bloc.dart';

abstract class EnrollState extends Equatable {
  const EnrollState();
  
  @override
  List<Object> get props => [];
}

class EnrollInitial extends EnrollState {
  const EnrollInitial();

  @override
  List<Object> get props => [];
}

class EnrollLoading extends EnrollState {
  const EnrollLoading();

  @override
  List<Object> get props => [];
}

class EnrollError extends EnrollState {
  final String message;
  const EnrollError(this.message);

  @override
  List<Object> get props => [message];
}

class EnrollMethodLoaded extends EnrollState {
  final EnrolModel data;
  const EnrollMethodLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class EnrollMethodInfoLoaded extends EnrollState {
  final EnrolModel data;
  const EnrollMethodInfoLoaded(this.data);

  @override
  List<Object> get props => [data];
}