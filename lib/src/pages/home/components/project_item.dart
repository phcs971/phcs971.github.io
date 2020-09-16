import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';

import '../../../utils/utils.dart';
import '../../../models/project.dart';

class ProjectItem extends StatelessWidget {
  final Project project;
  final int tick;
  ProjectItem(this.project, this.tick, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData techIcon = kTechToIcon[project.techs[tick % project.techs.length]];
    IconData statusIcon = kStatusToIcon[project.status];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: project.backgroundColor,
        boxShadow: kElevationToShadow[2],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Background
          ClipRRect(
            child: project.gallery[0].build(context),
            borderRadius: BorderRadius.circular(10),
          ),
          //Hexagon
          Transform.rotate(
            angle: pi / 2,
            child: ClipPath(
              clipper: HexagonClipper(),
              child: Container(color: Colors.black38, height: 100, width: 50 * sqrt(3)),
            ),
          ),
          //Title
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            child: Center(
              child: FittedBox(
                child: Text(
                  project.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            // padding: EdgeInsets.all(8),
          ),
          //Techs
          Positioned(
            bottom: 0,
            left: 0,
            height: 36,
            width: 36,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(right: 2, top: 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: kElevationToShadow[4],
                ),
                child: Icon(techIcon, color: Colors.white),
              ),
            ),
          ),
          //Status
          Positioned(
            top: 0,
            right: 0,
            height: 36,
            width: 36,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: kElevationToShadow[4],
                ),
                child: Icon(statusIcon, color: Colors.white),
              ),
            ),
          ),
          //Border
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            ),
          )
        ],
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    final h = size.height;

    void arcTo(double x, double y) => p.arcToPoint(Offset(x, y) * h,
        radius: Radius.circular(0.2 * h), rotation: pi * 2 / 3, clockwise: false);

    p.moveTo(0, 0.65 * h);
    arcTo(0.0866, 0.8);
    p.lineTo(0.3464 * h, 0.95 * h);
    arcTo(0.5196, 0.95);
    p.lineTo(0.7794 * h, 0.8 * h);
    arcTo(0.8660, 0.65);
    p.lineTo(0.8660 * h, 0.35 * h);
    arcTo(0.7794, 0.2);
    p.lineTo(0.5196 * h, 0.05 * h);
    arcTo(0.3264, 0.05);
    p.lineTo(0.0866 * h, 0.2 * h);
    arcTo(0, 0.35);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
