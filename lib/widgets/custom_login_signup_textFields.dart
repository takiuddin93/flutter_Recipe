import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe/utils/universal_variables.dart';

class CustomLoginSignUpTextField extends StatelessWidget {
  final String text;
  final TextEditingController fieldController;
  final bool validate, obscureText;
  final TextInputType keyboartType;
  final Size media;
  final BuildContext context;

  CustomLoginSignUpTextField(
      {Key key,
      this.text,
      this.fieldController,
      this.validate,
      this.obscureText,
      this.keyboartType,
      this.context,
      this.media})
      : super(key: key);

  var _keyboartType;
  Widget _prefixiconData;

  @override
  Widget build(BuildContext context) {
    if (obscureText == false) {
      _keyboartType = keyboartType;
      _prefixiconData = Icon(
        Icons.email,
        color: UniversalVariables.primaryDodgerBlue,
      );
    } else if (obscureText == true) {
      _keyboartType = TextInputType.text;
      _prefixiconData = Icon(
        Icons.lock,
        color: UniversalVariables.primaryDodgerBlue,
      );
    } else {
      _keyboartType = TextInputType.text;
      _prefixiconData = Icon(
        Icons.lock,
        color: UniversalVariables.primaryDodgerBlue,
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: UniversalVariables.primaryAlabaster,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: UniversalVariables.primaryGhostShadow,
            blurRadius: 4.0,
            spreadRadius: 4.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              autovalidate: validate,
              controller: fieldController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: _prefixiconData,
                ),
                labelText: text,
                labelStyle: TextStyle(
                    color: UniversalVariables.primaryDodgerBlue, fontSize: 20),
                hintText: text,
                hintStyle: TextStyle(
                    color: UniversalVariables.primaryDodgerBlueShadow,
                    fontSize: 18),
                fillColor: Colors.transparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  borderSide:
                      BorderSide(color: UniversalVariables.primaryDodgerBlue),
                ),
              ),
              obscureText: obscureText,
              keyboardType: _keyboartType,
              style: TextStyle(
                fontFamily: "FuturaPTMedium",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
