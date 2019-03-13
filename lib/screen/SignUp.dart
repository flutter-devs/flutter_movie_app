import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/Constants.dart';
import 'package:flutter_movie_app/util/FormValidator.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  bool _autoValidate = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final _nameController = new TextEditingController();
  final _emailIDController = new TextEditingController();
  final _passwordController = new TextEditingController();
  final _confirmPasswordController = new TextEditingController();

  String _name;
  String _emailID;
  String _password;
  String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FlutterLogo(
                    size: 80.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter name';
                      }
                    },
                    onSaved: (val) => _name = val,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailIDController,
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
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      }
                    },
                    onSaved: (val) => _password = val,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                    ),
                    validator: (value) {
                      return FormValidator.validateConfirmPassword(
                          _passwordController.text, value);
                    },
                    onSaved: (val) => _confirmPassword = val,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  FlatButton(
                    color: Colors.blue,
                    onPressed: _submitForm,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  GestureDetector(
                    onTap: _moveToSignIn,
                    child: Text('Already have an account? Sign in'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  isLoading ? CircularProgressIndicator() : new Container(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _moveToSignIn() {
    Navigator.of(context).pop(context);
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      Future.delayed(new Duration(seconds: 2), () {
        Navigator.of(context).pop(context);
        setState(() {
          isLoading = false;
        });
      });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
