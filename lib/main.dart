import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import './blocs/network bloc/network.dart';
import './pages/login_page.dart';
import './pages/demologin.dart';

void main() => runApp(
  BlocProvider<NetworkBloc>(
    create: (context){
      return NetworkBloc()..add(AppStarted());
    },
    child: App(),
  )
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DemoLogin(),
    );
  }
}

