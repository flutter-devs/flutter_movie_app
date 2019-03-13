import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/screen/SignUp.dart';
import 'package:flutter_movie_app/util/FormValidator.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool _autoValidate = false;

  String _emailID;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: new SingleChildScrollView(
                child: Column(
              children: <Widget>[
                FlutterLogo(
                  size: 80.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    hintText: 'Email ID',
                  ),
                  validator: (value) {
                    return FormValidator.validateEmail(value);
                  },
                  onSaved: (val) => _emailID = val,
                ),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Password',
                  ),
                  onSaved: (val) => _password = val,
                  validator: (value) {
                    if (value.isEmpty) return 'Enter Password';
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                FlatButton(
                  color: Colors.blue,
                  onPressed: _submitForm,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                GestureDetector(
                  onTap: _moveToSignUp,
                  child: Text('Not yet registered? Sign up'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                isLoading ? CircularProgressIndicator() : new Container(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        isLoading = true;
      });

      Future.delayed(new Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
        /*_scaffoldState.currentState
            .showSnackBar(new SnackBar(content: Text('Sign in successfull')));*/

        _moveToDashboard();
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _moveToSignUp() {
    /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignUp(),
          ));*/

    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
    Navigator.of(context).pushNamed(Constants.SIGN_UP);
  }

  void _moveToDashboard() {
    Navigator.of(context).pushReplacementNamed(Constants.DASHBOARD);
  }
}
