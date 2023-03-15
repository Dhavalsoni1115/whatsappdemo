import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constnts.dart';
import 'list_tile_card.dart';

class CallListTileCard extends StatelessWidget {
  const CallListTileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileCard(
      circleAvtarImage: const AssetImage("assets/images/profile.jpg"),
      listtileTitle: const Text("Dhruvit"),
      listtileSubTitle: Row(
        children: const[
           Icon(
            CupertinoIcons.arrow_down_left,
            size: 20,
            color: Colors.green,
          ),
           SizedBox(
            width: 5,
          ),
           Text(
            "Today,",
          ),
           Text("7:05 PM")
        ],
      ),
      listtileDate: const Icon(
        Icons.videocam,
        color: floatingActionButtonColor,
        size: 27,
      ),
    );
  }
}