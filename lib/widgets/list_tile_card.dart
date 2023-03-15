import 'package:flutter/material.dart';

class ListTileCard extends StatelessWidget {
  final dynamic circleAvtarImage, circleAvtarChild; //listtileDate;
  final Widget listtileDate, listtileSubTitle, listtileTitle;
  const ListTileCard({
    Key? key,
    required this.listtileTitle,
    required this.listtileSubTitle,
    required this.listtileDate,
    this.circleAvtarImage,
    this.circleAvtarChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.white38,
        backgroundImage: circleAvtarImage,
        child: circleAvtarChild,
      ),
      title: listtileTitle,
      subtitle: listtileSubTitle,
      trailing: listtileDate,
    );
  }
}
