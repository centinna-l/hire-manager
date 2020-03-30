import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hire_manager/blocs/network%20bloc/network_bloc.dart';
import './home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../values/global_variable.dart';

class DemoLogin extends StatefulWidget {
  @override
  _DemoLoginState createState() => _DemoLoginState();
}

class _DemoLoginState extends State<DemoLogin> {
  String _email;
  String _password;
  bool _isWorking = false;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  GloabalVariable email = new GloabalVariable();
    void getCurrentUser() async {
    try {
      final user = _auth.currentUser();
      if (user != null) {
        loggedInUser = user as FirebaseUser;
        debugPrint(loggedInUser.email);
      } else {
        Navigator.of(this.context).pushReplacement(
            MaterialPageRoute(builder: (context) => DemoLogin()));
      }
    } catch (e) {
      debugPrint(e);
    }
  }
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<NetworkBloc, NetworkState>(
        //bloc: NetworkBloc(),
        builder: (context, state) {
      if (state is NetworkCheck) {
        return SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.orangeAccent,
                child: Center(
                  child: ClipPath(
                    clipper: LoginCLipper(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(12),
                      height: 600,
                      width: 350,
                      child: _loginContainer(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isWorking = false;
                      });
                    }),
              ),
            ],
          ),
        );
      } else {
        return Container(
          color: Colors.orangeAccent,
          child: Center(
            child: ClipPath(
              clipper: LoginCLipper(),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.all(8),
                height: 600,
                width: 350,
                child: _loadingLoginContainer(),
              ),
            ),
          ),
        );
      }
    }));
  }

  ModalProgressHUD _loginContainer() {
    return ModalProgressHUD(
      color: Colors.orangeAccent,
      progressIndicator: CircularProgressIndicator(
        backgroundColor: Colors.orangeAccent,
      ),
      inAsyncCall: _isWorking,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Hero(
                tag: 'logo',
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                )),
          ),
          SizedBox(
            height: 150,
          ),
          Text(
            "Hire Manager",
            style: TextStyle(fontSize: 35),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                  email.email = value;
                });
              },
              decoration: InputDecoration(
                  suffix: Icon(Icons.email),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(color: Colors.orangeAccent)),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black))),
          SizedBox(
            height: 5,
          ),
          TextField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                  suffix: Icon(Icons.lock_outline),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(color: Colors.orangeAccent)),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black))),
          RaisedButton(
              onPressed: () async {
                setState(() {
                  _isWorking = true;
                });
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _email, password: _password)
                    .then((user) {
                  setState(() {
                    _isWorking = false;
                  });
                  Navigator.of(this.context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(0)));
                }).catchError((e) {
                  print(e);
                });
              },
              child: Text("Submit")),
        ],
      ),
    );
  }

  Column _loadingLoginContainer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Hero(
              tag: 'logo',
              child: Icon(
                Icons.person_outline,
                size: 50,
              )),
        ),
        SizedBox(
          height: 100,
        ),
        Text(
          "Hire Manager",
          style: TextStyle(fontSize: 35),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            decoration: InputDecoration(
              suffix: Icon(Icons.email),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelText: 'Email',
            )),
        SizedBox(
          height: 5,
        ),
        TextField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            decoration: InputDecoration(
              suffix: Icon(Icons.lock_outline),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              labelText: 'Password',
            )),
        SizedBox(
          height: 15,
        ),
        CircularProgressIndicator(
          backgroundColor: Colors.orangeAccent,
        ),
      ],
    );
  }
}

class LoginCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 350);
    path.lineTo(30, 0.5);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
