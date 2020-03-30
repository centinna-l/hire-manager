part of 'network_bloc.dart';

abstract class NetworkState extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState{}

class NetworkCheck extends NetworkState{
  final bool isNetwork;
  NetworkCheck({this.isNetwork});
  @override
  // TODO: implement props
  List<Object> get props => [isNetwork];
}

class NetworkLoading extends NetworkState{}

class NetworkError extends NetworkState{
  final String error;
  NetworkError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}