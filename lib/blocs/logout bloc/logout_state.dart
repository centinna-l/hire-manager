part of 'logout_bloc.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();
}

class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}

class LoggedOut extends LogoutState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LogoutError extends LogoutState{
  final String error;
  LogoutError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}