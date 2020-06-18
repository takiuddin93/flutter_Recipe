import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/constants/strings.dart';
import 'package:recipe/model/recipe.dart';
import 'package:recipe/screens/recipe_details.dart';
import 'package:recipe/utils/custom_top_curve_clipper.dart';
import 'package:recipe/utils/universal_variables.dart';
import 'package:recipe/widgets/custom_dialog_widget.dart';
import 'package:recipe/widgets/custom_user_circle.dart';

class Dashboard extends StatefulWidget {
  final String title, token;
  Dashboard({this.title, this.token, Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState(this.title, this.token);
}

class _DashboardState extends State<Dashboard> {
  List recipe = [];

  String title, token;
  _DashboardState(this.title, this.token);
  String alertdialogTitle,
      alertdialogDescription,
      alertdialogOkButton,
      alertdialogCancelButton;

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              left: width * 0.04,
              top: height * 0.17,
              right: width * 0.04,
              height: height * 0.84,
              child: Container(
                width: width * 0.92,
                child: Center(
                    child: GridView.builder(
                        padding: EdgeInsets.all(0.0),
                        itemCount: 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.64,
                            mainAxisSpacing: 0,
                            crossAxisCount: 1),
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                              future: _fetchRecipe(context: context),
                              builder: (context, snapshot) {
                                return snapshot.data != null
                                    ? makeDashboardItem(snapshot.data, media)
                                    : Center(
                                        child: CircularProgressIndicator());
                              });
                        })),
              )),
          Positioned(
            top: media.height * 0.0,
            child: ClipPath(
              clipper: DashboardTopCurveClipper(),
              child: Container(
                height: media.height,
                width: media.width,
                decoration: BoxDecoration(
                  color: UniversalVariables.primaryDodgerBlue,
                ),
              ),
            ),
          ),
          Positioned(
            left: width * 0.04,
            top: height * 0.04,
            right: width * 0.04,
            child: Container(
              width: width * 0.92,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.all(0.0), child: UserCircle()),
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _buildLabel(context),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: IconButton(
                      color: UniversalVariables.primaryAlabaster,
                      icon: new Icon(
                        Icons.search,
                        size: 32.0,
                      ),
                      onPressed: () {
                        alertdialogTitle = 'Search';
                        alertdialogDescription =
                            'This feature has not been implemented yet!';
                        alertdialogOkButton = 'Ok';
                        alertdialogCancelButton = 'Cancel';
                        CustomDialog.showScaleAlertBox(
                          context: context,
                          title: alertdialogTitle,
                          icon: Icons.info_outline,
                          text: alertdialogDescription,
                          firstButton: title == 'Hi, Test'
                              ? alertdialogOkButton
                              : alertdialogCancelButton,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: width * 0.06,
            top: height * 0.05,
            right: width * 0.06,
            child: Container(
              width: width * 0.84,
              height: height * 0.16,
              padding: EdgeInsets.symmetric(
                vertical: height * 0.0,
                horizontal: 0.0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: "Recipes",
                      style: TextStyle(
                          color: UniversalVariables.primaryAlabaster,
                          fontSize: 24.0,
                          fontFamily: 'FuturaPTBold'),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Data>> _fetchRecipe({BuildContext context}) async {
    try {
      var recipedetailsRequest = await http.get(
          // Encode the url
          RECIPE_DETAILS_API_URL,
          headers: {
            'Content-Type': 'application/json',
            HttpHeaders.authorizationHeader: "Bearer " + token,
          });

      print(recipedetailsRequest.statusCode);
      if (recipedetailsRequest.statusCode == 200) {
        Map<String, dynamic> recipedetails =
            json.decode(recipedetailsRequest.body);
        var data = recipedetails["data"] as List;
        recipe = data.map<Data>((json) => Data.fromJson(json)).toList();
      } else {
        alertdialogTitle = 'Expired';
        alertdialogDescription =
            'Token has expired. Please login, to refresh token!';
        alertdialogOkButton = 'Ok';
        alertdialogCancelButton = 'Cancel';
        CustomDialog.showScaleAlertBox(
          context: context,
          title: alertdialogTitle,
          icon: Icons.info_outline, // IF YOU WANT TO ADD ICON
          text: alertdialogDescription, // IF YOU WANT TO ADD
          firstButton: alertdialogOkButton,
        );
      }
    } catch (e) {
      print(e);
    }

    return recipe;
  }

  Align _buildLabel(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          style: new TextStyle(
            fontFamily: 'FuturaPTMedium',
            fontSize: 20.0,
            color: UniversalVariables.primaryAlabaster,
          ),
          children: [
            TextSpan(
              text: "Hi, " + title,
            ),
          ],
        ),
      ),
    );
  }

  Widget makeDashboardItem(List<Data> data, Size media) {
    double width = media.width;
    double height = media.height;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, position) {
          return Container(
            padding: EdgeInsets.all(0.0),
            height: height * 0.24,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetails(
                        token: token, title: data[position].title, data: data),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Background
                  Container(
                    height: height * 0.18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: 1.isEven
                            ? UniversalVariables.primaryDodgerBlue
                            : UniversalVariables.primaryGhost,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 8,
                              color: UniversalVariables
                                  .primaryDodgerBlueShadow // Black color with 12% opacity
                              ),
                        ]),
                    child: Container(
                      margin: EdgeInsets.only(right: width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  // Recipe Image
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      height: height * 0.20,
                      width: width * 0.52,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          data[position].imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Recipe Title and Serving
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: height * 0.18,
                      // our image take 200 width, thats why we set out total width - 200
                      width: width - (width * 0.58),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.06),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: data[position].title,
                                  style: TextStyle(
                                      color:
                                          UniversalVariables.primaryDodgerBlue,
                                      fontSize: 14.0,
                                      fontFamily: 'FuturaPTBold'),
                                ),
                              ]),
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.06 * 1.5,
                              vertical: width * 0.06 / 4,
                            ),
                            decoration: BoxDecoration(
                              color: UniversalVariables.primaryGhost,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8.0),
                                topLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: data[position].servings.toString(),
                                  style: TextStyle(
                                      color:
                                          UniversalVariables.primaryDodgerBlue,
                                      fontSize: 12.0,
                                      fontFamily: 'FuturaPTBold'),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
