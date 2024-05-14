import 'package:flutter/material.dart';

String uri = 'https://elitearketv2-1-1.onrender.com';
String url = 'https://elitemarket-v2-8.onrender.com';
String appname = "EliteMarket";
const slider1 = "assets/images/slider1.jpeg";
const slider2 = "assets/images/slider2.jpg";
const slider3 = "assets/images/slider3.jpg";
const sliderlist = [slider1, slider2, slider3];

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(230, 46, 4, 1),
      Color.fromRGBO(230, 46, 4, 1),
    ],
    stops: [2.0, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromRGBO(230, 46, 4, 1);
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    "assets/images/slider1.jpeg",
    "assets/images/slider2.jpg",
    "assets/images/slider3.jpg",
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
