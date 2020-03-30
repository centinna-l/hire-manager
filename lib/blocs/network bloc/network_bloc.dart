import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_manager/blocs/network%20bloc/network.dart';
import '../../network/connectivity.dart';

part 'network_event.dart';
part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent,NetworkState>{
  @override
  // TODO: implement initialState
  NetworkState get initialState => NetworkInitial();

   _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      return false;
    } else if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
     return true;
    }
  }

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async*{
    if(event is AppStarted){
      yield NetworkLoading();
      var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      yield NetworkError("No Internet");
    } else if (result == ConnectivityResult.mobile) {
      yield NetworkCheck(isNetwork: true);
    } else if (result == ConnectivityResult.wifi) {
     yield NetworkCheck(isNetwork: true);
    }
    }
  }
}