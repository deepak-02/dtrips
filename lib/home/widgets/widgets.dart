import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget hotDestinationCard(dynamic imagePath, dynamic placeName,
    dynamic touristPlaceCount, dynamic cityId, BuildContext context) {
  return Stack(children: [
    Hero(
      tag: imagePath,
      child: Container(
        height: 200,
        width: 140,
        margin: const EdgeInsets.only(right: 25),
        padding: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
    Positioned(
      top: 0,
      left: 0,
      child: Container(
        height: 200,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.center,
              colors: [
                Color(0xcb250d2f), Colors.transparent
                // Color(0xFFFFFF)
              ]),
        ),
      ),
    ),
    Positioned(
      bottom: 20,
      left: 20,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              placeName.toString().toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              touristPlaceCount.toString().toUpperCase(),
              style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  color: Colors.white),
            ),
          ]),
    ),
  ]);
}

final List<String> imageList = [
  'assets/images/1.jpg',
  'assets/images/2.jpg',
  'assets/images/3.jpg',
  'assets/images/4.jpg',
  'assets/images/6.jpg',
  'assets/images/7.jpg',
  'assets/images/8.jpg',
  'assets/images/9.jpg',
  'assets/images/10.jpg',
  'assets/images/11.jpg',
  'assets/images/12.jpg',
  'assets/images/13.jpg',
  'assets/images/14.jpg',
];

class MyCarousel extends StatelessWidget {
  const MyCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 8, // Set the aspect ratio of the carousel items
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.linear,
        pauseAutoPlayOnTouch: true,
      ),
      items: imageList.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(item),
                  fit: BoxFit.fill,
                ),
              ),
              // child: Image.asset(item, fit: BoxFit.cover),
            );
          },
        );
      }).toList(),
    );
  }
}
