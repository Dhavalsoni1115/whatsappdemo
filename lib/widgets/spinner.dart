import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:whatsappdemo/constnts.dart';

class SpinnerScreen extends StatelessWidget {
  const SpinnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeInOut(
  color: appBarColor,
  size: 50.0,
 //controller: AnimationController(vsync: , duration: const Duration(milliseconds: 1200)),
);
  }
}
