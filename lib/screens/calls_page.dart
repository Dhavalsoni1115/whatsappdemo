import 'package:flutter/material.dart';
import '../widgets/call_list_tile_card.dart';
import '../widgets/list_tile_card.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTileCard(
          circleAvtarChild: Icon(
            Icons.link_outlined,
            color: Colors.white,
          ),
          listtileTitle: Text("My Status"),
          listtileSubTitle: Text("Tap to add status update"),
          listtileDate: Text(""),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            "Recent",
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        const CallListTileCard(),
      ],
    );
  }
}
