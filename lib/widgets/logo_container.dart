import 'package:flutter/cupertino.dart';

import '../constnts.dart';

class LogoContainer extends StatelessWidget {
  const LogoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: appBarColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: const Image(
        image: AssetImage('assets/images/logo.png'),
        fit: BoxFit.contain,
      ),
    );
  }
}