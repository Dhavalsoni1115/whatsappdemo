import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/data/firestore_data.dart';
import 'package:whatsappdemo/screens/message_type_page.dart';

import '../widgets/list_tile_card.dart';

class ChatsScreen extends StatefulWidget {
  final String userId, userName, userEmail;

  const ChatsScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  void initState() {
    super.initState();
    chatData();
  }

  dynamic chatScreenData = [];
  Future<dynamic> chatData() async {
    dynamic chatScreenData1 = await getAllMessage();
    setState(() {
      chatScreenData = chatScreenData1;
    });
    return chatScreenData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatScreenData.length,
        itemBuilder: (context, index) => 
        chatScreenData[index]['message'][0]['senderName'] ==
                widget.userName
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageTypeScreen(
                        senderId: widget.userId,
                        senderName: widget.userName,
                        senderEmail: widget.userEmail,
                        reciverId: chatScreenData[index]['message'][0]['reciverId'],
                        reciverName: chatScreenData[index]['message'][0]['reciverName'],
                      ),
                    ),
                  );
                },
                child: ListTileCard(
                  circleAvtarImage: const AssetImage("assets/images/profile.jpg"),
                  listtileTitle:
                      Text(chatScreenData[index]['message'][0]['reciverName']),
                  listtileSubTitle: const Text("Kale raja 6e avta nai"),
                  listtileDate: Text("yesterday", style: listCardStyle),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
