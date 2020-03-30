part of 'network_bloc.dart';

abstract class NetworkEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends NetworkEvent{}