import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  const FoodImage({super.key, required this.photoLink});
  final photoLink;

  @override
  Widget build(BuildContext context) {
    if(photoLink != ''){
      return Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
        child:Image(
          image: NetworkImage(photoLink),
        ),
      );
    }else{
      return const Padding(
        padding: EdgeInsets.only(top: 0, bottom: 30, left: 30, right: 30),
      );
    }
  }
}

