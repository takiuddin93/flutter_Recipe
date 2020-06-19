import 'package:flutter/material.dart';
import 'package:recipe/model/recipe.dart';
import 'package:recipe/widgets/product_image.dart';
import 'package:recipe/utils/universal_variables.dart';
import 'package:recipe/widgets/custom_appbar.dart';

class RecipeDetails extends StatefulWidget {
  final String token, title;
  final List<Data> data;

  const RecipeDetails({Key key, this.token, this.title, this.data})
      : super(key: key);
  @override
  _RecipeDetailsState createState() =>
      _RecipeDetailsState(this.token, this.title, this.data);
}

class _RecipeDetailsState extends State<RecipeDetails>
    with TickerProviderStateMixin {
  String title, token;
  List<Data> data;
  _RecipeDetailsState(this.token, this.title, this.data);

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    double width = media.width;
    double height = media.height;
    return Scaffold(
      backgroundColor: UniversalVariables.primaryDodgerBlue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(media.height),
        child: CustomAppBar(back: "details", title: title, token: token),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: height * 0.0,
            child: Container(
              height: height * 0.48,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: UniversalVariables.primaryAlabaster,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: ProductPoster(
                      media: media,
                      image: data[0].imageUrl,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: RichText(
                      text: TextSpan(
                        text: data[0].title,
                        style: new TextStyle(
                          fontFamily: 'FuturaPTMedium',
                          fontSize: 20,
                          color: UniversalVariables.primaryDodgerBlue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Icon(Icons.timer,
                                color: UniversalVariables.primaryDodgerBlue)),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 7,
                          child: RichText(
                            text: TextSpan(
                              text: data[0].totalTime.toString(),
                              style: new TextStyle(
                                fontFamily: 'FuturaPTMedium',
                                fontSize: 16,
                                color: UniversalVariables.primaryDodgerBlue,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Icon(
                              Icons.people,
                              color: UniversalVariables.primaryDodgerBlue,
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 7,
                          child: RichText(
                            text: TextSpan(
                              text: data[0].servings.toString(),
                              style: new TextStyle(
                                fontFamily: 'FuturaPTMedium',
                                fontSize: 16,
                                color: UniversalVariables.primaryDodgerBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            width: width,
            top: height * 0.48,
            child: Container(
              height: height * 0.08,
              child: TabBar(
                tabs: [
                  Container(
                    width: width * 0.50,
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Ingredients",
                          style: new TextStyle(
                            fontFamily: 'FuturaPTMedium',
                            fontSize: 18,
                            // color: UniversalVariables.primaryAlabaster,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.50,
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: TextSpan(
                          text: "Directions",
                          style: new TextStyle(
                            fontFamily: 'FuturaPTMedium',
                            fontSize: 18,
                            // color: UniversalVariables.primaryAlabaster,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                unselectedLabelColor:
                    UniversalVariables.primaryDodgerBlueShadow,
                indicatorColor: UniversalVariables.primaryAlabaster,
                labelColor: UniversalVariables.primaryAlabaster,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 4.0,
                indicatorPadding: EdgeInsets.only(
                    left: 32.0, top: 0.0, right: 32.0, bottom: 8.0),
                isScrollable: false,
                controller: _tabController,
              ),
            ),
          ),
          Positioned(
            width: width,
            top: height * 0.56,
            child: Container(
              color: UniversalVariables.transparent,
              height: height * 0.32,
              child: TabBarView(controller: _tabController, children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                      left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                  child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (width / height),
                      padding: EdgeInsets.all(3.0),
                      children: <Widget>[
                        ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          itemCount: data[0].ingredients.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ingredients(
                                data[0].ingredients[index].id.toString(),
                                data[0].ingredients[index].name,
                                data[0].ingredients[index].displayQuantity,
                                media);
                          },
                        ),
                      ]),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: 8.0, top: 16.0, right: 8.0, bottom: 0.0),
                  child: GridView.builder(
                      padding: EdgeInsets.all(0.0),
                      itemCount: 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.64,
                          mainAxisSpacing: 0,
                          crossAxisCount: 1),
                      itemBuilder: (context, index) {
                        return ListView.builder(
                          padding: EdgeInsets.all(0.0),
                          itemCount: data[0].directions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return directions(
                                data[0].directions[index].step.toString(),
                                data[0].directions[index].text,
                                media);
                          },
                        );
                      }),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  Container ingredients(
      String id, String name, String displayQuantity, Size media) {
    return Container(
      padding: EdgeInsets.only(left: 4.0, top: 0.0, right: 4.0, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: id + ".",
                      style: new TextStyle(
                        fontFamily: 'FuturaPTMedium',
                        fontSize: 16,
                        color: UniversalVariables.primaryAlabaster,
                      ),
                    ),
                  ),
                ]),
          ),
          Expanded(
            flex: 9,
            child: new Padding(
              padding: EdgeInsets.only(
                  left: media.width * 0.04,
                  top: media.height * 0.0,
                  right: media.width * 0.0,
                  bottom: media.height * 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: displayQuantity + " x " + name,
                    style: new TextStyle(
                      fontFamily: 'FuturaPTMedium',
                      fontSize: 16,
                      color: UniversalVariables.primaryAlabaster,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container directions(String step, String text, Size media) {
    return Container(
      padding: EdgeInsets.only(left: 4.0, top: 0.0, right: 4.0, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: RichText(
                text: TextSpan(
                  text: step + ".",
                  style: new TextStyle(
                    fontFamily: 'FuturaPTMedium',
                    fontSize: 16,
                    color: UniversalVariables.primaryAlabaster,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: new Padding(
              padding: EdgeInsets.only(
                  left: media.width * 0.04,
                  top: media.height * 0.0,
                  right: media.width * 0.0,
                  bottom: media.height * 0.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: text,
                    style: new TextStyle(
                      fontFamily: 'FuturaPTMedium',
                      fontSize: 16,
                      color: UniversalVariables.primaryAlabaster,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
