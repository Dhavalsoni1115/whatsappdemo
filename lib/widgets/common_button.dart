import 'package:flutter/material.dart';
import '../constnts.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonName;
  const CommonButton({
    Key? key,
    required this.onTap,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
