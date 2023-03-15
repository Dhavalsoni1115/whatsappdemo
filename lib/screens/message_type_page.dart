import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/data/firestore_data.dart';

class MessageTypeScreen extends StatefulWidget {
  final String senderId, senderName, senderEmail;
  final String reciverId, reciverName;
  const MessageTypeScreen({
    Key? key,
    required this.senderId,
    required this.senderName,
    required this.senderEmail,
    required this.reciverId,
    required this.reciverName,
  }) : super(key: key);

  @override
  State<MessageTypeScreen> createState() => _MessageTypeScreenState();
}

String? message;

class _MessageTypeScreenState extends State<MessageTypeScreen> {
  final TextEditingController userMassage = TextEditingController();
  final _messageformKey = GlobalKey<FormState>();

  dynamic allMessageData = [];
  Future<dynamic> messageData() async {
    final List<dynamic> userId = [widget.senderId, widget.reciverId];
    userId.sort();
    dynamic messageData1 = await getMessage(docId: '${userId[0]}${userId[1]}');
    setState(() {
      allMessageData = messageData1.data();
    });
  }

  @override
  void initState() {
    super.initState();
    messageData();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> userId = [widget.senderId, widget.reciverId];
    userId.sort();
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.reciverName),
            ],
          ),
          actions: const[
             Icon(
              Icons.videocam,
              size: 25,
            ),
             SizedBox(width: 15),
             Icon(
              Icons.call_outlined,
              size: 25,
            ),
             SizedBox(width: 10),
             Icon(
              Icons.more_vert_outlined,
              size: 25,
            ),
             SizedBox(width: 10),
          ],
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: allMessageData?['message']?.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: allMessageData?['message']?[index]
                              ?['senderId'] ==
                          widget.senderId
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Container(
                              width: 250,
                              padding: const EdgeInsets.all(10),
                              child: Expanded(
                                child: Text(
                                  allMessageData['message'][index]['chat'],
                                ),
                              ),
                            ),
                          ],
                        ),
                        //  Text('....'),
                        shape: allMessageData['message'][index]['senderId'] ==
                                widget.senderId
                            ? RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                // child: Text("Hello"),
                              )
                            : RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                // child: Text("Hello"),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          //color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.sentiment_satisfied_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          //height: 20,
                          width: 210,
                          child: Expanded(
                            // flex: 2,
                            child: Form(
                              key: _messageformKey,
                              child: TextFormField(
                                controller: userMassage,
                                //maxLength: null,
                                maxLines: 8,
                                minLines: 1,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Message"),
                                onChanged: (value) {
                                  message = value;
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        if (_messageformKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message!),
                            ),
                          );
                        }
                        final List<String> userId = [
                          widget.senderId,
                          widget.reciverId
                        ];
                        userId.sort();
                        List<dynamic> chatData = [
                          {
                            'senderId': widget.senderId,
                            'senderName': widget.senderName,
                            'reciverId': widget.reciverId,
                            'reciverName': widget.reciverName,
                            'dateTime': DateTime.now(),
                            'chat': message!,
                          }
                        ];
                        if (allMessageData != null &&
                            allMessageData['message'].isNotEmpty) {
                          chatData = [
                            ...allMessageData['message'],
                            {
                              'senderId': widget.senderId,
                              'senderName': widget.senderName,
                              'reciverId': widget.reciverId,
                              'reciverName': widget.reciverName,
                              'dateTime': DateTime.now(),
                              'chat': message!,
                            }
                          ];
                        }
                        await addMessage(
                          docId: '${userId[0]}${userId[1]}',
                          message: chatData,
                        );

                        setState(() {
                          messageData();
                          userMassage.clear();
                        });
                      },
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: appBarColor,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
