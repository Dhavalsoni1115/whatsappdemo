
import 'package:flutter/material.dart';

const appBarColor = Color(0xFF26A72D);

const floatingActionButtonColor = Color(0xFF28B8A7);

final listCardStyle = TextStyle(color: Colors.grey.shade500, fontSize: 10);

const stackCircleAvtar = CircleAvatar(
  radius: 13,
  backgroundColor: Colors.white,
  child: CircleAvatar(
    radius: 11,
    backgroundColor: appBarColor,
    child: Center(
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 20,
      ),
    ),
  ),
);
