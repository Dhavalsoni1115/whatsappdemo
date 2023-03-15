import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/data/firestore_data.dart';
import 'package:whatsappdemo/screens/message_type_page.dart';
import 'package:whatsappdemo/widgets/list_tile_card.dart';

class ContactScreen extends StatefulWidget {
  final String userId, userName, userEmail;
  const ContactScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<dynamic> userallData = [];
  Future<dynamic> userData() async {
    List<dynamic> userallData1 = await getUser();
    setState(() {
      userallData = userallData1;
    });
    return userallData;
  }

  @override
  void initState() {
    super.initState();
    userData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Select contact'),
        actions: const[
           Icon(
            Icons.search,
            size: 30,
          ),
           SizedBox(width: 20),
           Icon(
            Icons.more_vert_outlined,
            size: 30,
          ),
           SizedBox(width: 20),
        ],
      ),
      body: ListView.builder(
        itemCount: userallData.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
           // getMessage(docId: widget.userId + userallData[index]['id']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageTypeScreen(
                  senderId: widget.userId,
                  senderName: widget.userName,
                  senderEmail: widget.userEmail,
                  reciverId: userallData[index]['id'],
                  reciverName: userallData[index]['name'],
                ),
              ),
            );
          },
          child: widget.userName != userallData[index]['name']
              ? ListTileCard(
                  listtileTitle: Text(userallData[index]['name']),
                  listtileSubTitle: Text(userallData[index]['email']),
                  listtileDate: const Text(''),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
