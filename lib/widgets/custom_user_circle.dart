import 'package:flutter/material.dart';
import 'package:recipe/utils/universal_variables.dart';

class UserCircle extends StatelessWidget {
  final GestureTapCallback onTap;

  UserCircle({
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: 42,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: UniversalVariables.primaryDodgerBlueShadow,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              "assets/images/taki.jpg",
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            )),
      ),
    );
  }
}
