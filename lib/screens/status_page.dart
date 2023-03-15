import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';

import '../widgets/list_tile_card.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: const [
              ListTileCard(
                circleAvtarImage: AssetImage("assets/images/profile.jpg"),
                listtileTitle: Text("My Status"),
                listtileSubTitle: Text("Tap to add status update"),
                listtileDate: Text(""),
              ),
              Padding(
                padding: EdgeInsets.only(top: 36, left: 42),
                child: stackCircleAvtar,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Viewed updates",
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          const ListTileCard(
            circleAvtarImage: AssetImage("assets/images/profile.jpg"),
            listtileTitle: Text("Dhruvit"),
            listtileSubTitle: Text("19 minutes ago"),
            listtileDate: Text(""),
          ),
        ],
      ),
    );
  }
}
