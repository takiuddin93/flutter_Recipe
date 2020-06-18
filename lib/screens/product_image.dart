import 'package:flutter/material.dart';

class ProductPoster extends StatelessWidget {
  const ProductPoster({
    Key key,
    @required this.media,
    this.image,
  }) : super(key: key);

  final Size media;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: media.width * 0.05, vertical: media.width * 0.05),
      height: media.width * 0.64,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: media.width * 0.8,
            width: media.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(32.0),
            child: Image.network(
              image,
              height: media.width * 0.75,
              width: media.width * 0.75,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
