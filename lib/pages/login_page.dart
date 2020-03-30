import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../blocs/network bloc/network.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../validators/validator.dart';
import './home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String _email;
  String _password;

  var _validator = Validators();
  bool validated = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            topContainer(),
            bottomContainer(),
            loginContainer()
          ],
        ),
      ),
    );
  }

  Align topContainer() {
    return Align(
      alignment: Alignment.topLeft,
      child: ClipPath(
        child: Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.redAccent, Colors.pinkAccent],
            ),
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        clipper: CurveClipper(),
      ),
    );
  }

  Align bottomContainer() {
    return Align(
      alignment: Alignment.bottomRight,
      child: ClipPath(
        child: Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.redAccent, Colors.pinkAccent],
            ),
            border: Border.all(),
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        clipper: BottomCurve(),
      ),
    );
  }

  Align loginContainer() {
    return Align(
      alignment: Alignment.center,
      child: BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
        return ClipPath(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(),
                borderRadius: BorderRadius.circular(25),
              ),
              height: 570,
              width: 330,
              child: Align(
                alignment: Alignment.topLeft,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Hero(
                          tag: 'person',
                          child: Icon(
                            Icons.person_outline,
                            size: 50,
                          ),
                        )),
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Hire Manager",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _email = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  suffix: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  suffix: Icon(Icons.email),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                )),
                            SizedBox(
                              height: 8,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: state is NetworkCheck
                                  ? Container(
                                      width: 120,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.redAccent,
                                            Colors.pinkAccent
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: InkWell(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onTap: () {
                                            FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                                    email: _email,
                                                    password: _password)
                                                .then((user) {
                                              Navigator.of(this.context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(0)));
                                            }).catchError((e) {
                                              print(e);
                                            });
                                          },
                                          focusColor: Colors.redAccent,
                                        ),
                                      ),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          clipper: LoginCLipper(),
        );
      }),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 35);
    var firstControlPoint = Offset(size.width / 2.85, size.height);
    var firstEndPoint = Offset(size.width, size.height - 150);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height - 150);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }
}

class BottomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(size.width, 0);
    var firstControlPoint = Offset(size.width / 3.89, size.height / 2);
    var firstEndPoint = Offset(size.width, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginCLipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - 350);
    path.lineTo(30, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
