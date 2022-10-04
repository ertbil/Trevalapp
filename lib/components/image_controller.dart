import 'package:flutter/material.dart';

Image imageController(String image) {
  if(image == "Image not found"){
    return const Image(image: AssetImage("assets/images/no_image.png"));
  }
  else {
    try {
      var image2 = Image.network(image);
      return image2;
    } catch (e) {
      print(e);
      return const Image(image: AssetImage("assets/images/no_image.png"));
    }
  }

}