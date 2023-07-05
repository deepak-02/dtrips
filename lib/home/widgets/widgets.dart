import 'package:flutter/material.dart';
import 'dart:math' as math;

Widget hotDestinationCard(dynamic imagePath, dynamic placeName,
    dynamic touristPlaceCount, dynamic cityId, BuildContext context) {
  final screenSize = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation.name;
  return Stack(children: [
    Hero(
      tag: imagePath,
      child: Container(
        height: 200,
        width: 140,
        margin: EdgeInsets.only(right: 25),
        padding: EdgeInsets.only(bottom: 20),
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
          gradient: LinearGradient(
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
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: Colors.white),
            ),
            SizedBox(height: 4),
            Text(
              touristPlaceCount.toString().toUpperCase(),
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                  color: Colors.white),
            ),
          ]),
    ),
  ]);
}
