import 'package:recipe/screens/dashboard.dart';
import 'package:recipe/utils/universal_variables.dart';
import 'package:recipe/utils/custom_appbar_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title, back, token;

  const CustomAppBar({Key key, this.title, this.back, this.token})
      : super(key: key);
  static String alertdialogTitle,
      alertdialogDescription,
      alertdialogOkButton,
      alertdialogCancelButton;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: appBarHeight(context),
        color: UniversalVariables.primaryDodgerBlue,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: _buildleading(context),
                ),
              ),
              Expanded(
                flex: 12,
                child: Align(
                  alignment: Alignment.center,
                  child: _buildLabel(context),
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildaction(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Builder _buildleading(BuildContext context) {
    IconData _iconData;
    switch (back.toString()) {
      case "recipe":
        {
          _iconData = null;
        }
        break;
      case "details":
        {
          _iconData = Icons.arrow_back;
        }
        break;
      default:
        {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  Dashboard(title: "Test", token: token)));
        }
        break;
    }
    return Builder(
      builder: (context) => IconButton(
        color: UniversalVariables.primaryAlabaster,
        icon: new Icon(
          _iconData,
          color: UniversalVariables.primaryAlabaster,
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  Dashboard(title: "Test", token: token)));
        },
      ),
    );
  }

  Align _buildLabel(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          style: new TextStyle(
            fontFamily: 'FuturaPTMedium',
            fontSize: 20.0,
            color: UniversalVariables.primaryAlabaster,
          ),
          children: [
            TextSpan(
              text: title,
            ),
          ],
        ),
      ),
    );
  }

  Builder _buildaction(BuildContext context) {
    IconData _actioniconData;
    switch (back.toString()) {
      case "recipe":
        {
          _actioniconData = null;
        }
        break;
      default:
        {
          _actioniconData = null;
        }
        break;
    }

    return Builder(
      builder: (context) => IconButton(
        color: UniversalVariables.primaryDodgerBlue,
        icon: new Icon(
          _actioniconData,
          size: 32.0,
        ),
        onPressed: () {},
      ),
    );
  }
}
