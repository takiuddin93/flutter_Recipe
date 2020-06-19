import 'package:recipe/screens/login.dart';
import 'package:recipe/utils/universal_variables.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static Future showScaleAlertBox({
    @required BuildContext context,
    @required String title,
    IconData icon,
    @required String text,
    @required String firstButton,
  }) {
    return showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.7),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                title: Center(
                    child: Text(
                  title,
                  style: TextStyle(color: UniversalVariables.primaryEbony),
                )),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      icon,
                      color: UniversalVariables.primaryCrimson,
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        text,
                        style:
                            TextStyle(color: UniversalVariables.primaryEbony),
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    color: Colors.white,
                    child: Text(firstButton),
                    onPressed: () {
                      if (firstButton == "Cancel") {
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                          return new Login();
                        }));
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 128),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return null;
        });
  }
}
