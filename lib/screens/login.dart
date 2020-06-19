import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/constants/strings.dart';
import 'package:recipe/screens/dashboard.dart';
import 'package:recipe/utils/universal_variables.dart';
import 'package:recipe/widgets/custom_login_signup_textFields.dart';

var _loginSuccess;
bool _validate = false;
bool _loginTapped = false;
bool _errorVisible = false;
TextEditingController _email = new TextEditingController();
TextEditingController _password = new TextEditingController();

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState(this.title);
}

class _LoginPageState extends State<Login> {
  String title;
  _LoginPageState(this.title);
  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: height * 0.16,
            width: media.width,
            child: Container(
              width: width,
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: title,
                      style: TextStyle(
                          color: UniversalVariables.primaryDodgerBlue,
                          fontSize: 32.0,
                          fontFamily: 'FuturaPTBold'),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          // Email
          Positioned(
            width: media.width,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: media.height * 0.40,
                  left: media.width * 0.10,
                  right: media.width * 0.10,
                ),
                child: CustomLoginSignUpTextField(
                    text: "Email",
                    fieldController: _email,
                    validate: _validate,
                    obscureText: false,
                    keyboartType: TextInputType.text,
                    media: media),
              ),
            ),
          ),
          // Email error message
          Positioned(
            width: media.width,
            child: Visibility(
              visible: _errorVisible,
              child: Container(
                padding: EdgeInsets.only(
                  top: media.height * 0.48,
                  left: media.width * 0.10,
                  right: media.width * 0.10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Email cannot be empty",
                        style: TextStyle(
                          color: UniversalVariables.primaryCrimson,
                          fontSize: 14.0,
                          fontFamily: 'FuturaPTBook',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Password
          Positioned(
            width: media.width,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: media.height * 0.52,
                  left: media.width * 0.10,
                  right: media.width * 0.10,
                ),
                child: CustomLoginSignUpTextField(
                    text: "Password",
                    fieldController: _password,
                    validate: _validate,
                    obscureText: true,
                    keyboartType: TextInputType.number,
                    media: media),
              ),
            ),
          ),
          // Password error message
          Positioned(
            width: media.width,
            child: Visibility(
              visible: _errorVisible,
              child: Container(
                padding: EdgeInsets.only(
                  top: media.height * 0.60,
                  left: media.width * 0.10,
                  right: media.width * 0.10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Password cannot be empty",
                        style: TextStyle(
                          color: UniversalVariables.primaryCrimson,
                          fontSize: 14.0,
                          fontFamily: 'FuturaPTBook',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Submit Button
          Positioned(
              top: media.height * 0.7,
              left: media.width * 0.6,
              right: media.width * 0.10,
              child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: media.height * 0.0,
                        left: media.width * 0.0,
                        bottom: 0.0,
                        right: media.width * 0.0),
                    height: media.height * 0.05,
                    width: media.width,
                    decoration: BoxDecoration(
                      color: UniversalVariables.primaryDodgerBlue,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (_loginTapped != true)
                          Text(
                            "Login",
                            style: TextStyle(
                              color: UniversalVariables.primaryAlabaster,
                              fontSize: 18,
                              fontFamily: 'FuturaPTMedium',
                            ),
                          )
                        else
                          _loginSuccess == false || _loginSuccess == null
                              ? CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      UniversalVariables.primaryAlabaster))
                              : Text(
                                  "Success",
                                  style: TextStyle(
                                    color: UniversalVariables.primaryAlabaster,
                                    fontSize: media.width * 0.037,
                                    fontFamily: 'FuturaPTMedium',
                                  ),
                                ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _loginTapped = true;
                    });
                    _validateInputs();
                  })),
        ],
      ),
    );
  }

  _validateInputs() async {
    if (_email.text != '' && _password.text != '') {
      try {
        var loginRequest = await http.post(LOGIN_API_URL,
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              "email": _email.text,
              "password": _password.text
            }));

        Map<String, dynamic> data = json.decode(loginRequest.body);

        if (data["response"].toString() == "success") {
          String token = data["result"]["token"].toString();
          var userdetailsRequest =
              await http.get(USER_DETAILS_API_URL, headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Bearer " + token,
          });

          Map<String, dynamic> userdetails =
              json.decode(userdetailsRequest.body);
          setState(() {
            _loginSuccess = true;
          });
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new Dashboard(
              title: userdetails["result"]["name"].toString(),
              token: data["result"]["token"].toString(),
            );
          }));
        } else {
          setState(() {
            _loginTapped = false;
            _loginSuccess = false;
          });
        }
      } catch (e) {
        setState(() {
          _loginTapped = false;
          _loginSuccess = false;
        });
        throw e;
      }
    } else {
      setState(() {
        _loginTapped = false;
        _loginSuccess = false;
        _validate = true;
        _errorVisible = true;
      });
    }
  }
}
