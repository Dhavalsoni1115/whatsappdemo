import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/screens/calls_page.dart';
import 'package:whatsappdemo/screens/chats_page.dart';
import 'package:whatsappdemo/screens/contact_page.dart';
import 'package:whatsappdemo/screens/group_page.dart';
import 'package:whatsappdemo/screens/setting_page.dart';
import 'package:whatsappdemo/screens/status_page.dart';

import '../data/firestore_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  IconData floatingActionButtonIcon = Icons.chat_rounded;
  dynamic userId, userName, userEmail, userPassword;
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  List<dynamic> userData = [];
  Future<dynamic> getUserId() async {
    dynamic currentUserEmail = getCurrentUser();
    List<dynamic> userData1 = await getUser();
    for (var user in userData1) {
      if (currentUserEmail == user['email']) {
        //print(user);
        setState(() {
          userId = user['id'];
          userName = user['name'];
          userEmail = user['email'];
          userPassword = user['password'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: appBarColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactScreen(
                  userId: userId,
                  userName: userName,
                  userEmail: userEmail,
                ),
              ),
            );
          },
          child: Icon(floatingActionButtonIcon),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text('WhatsApp'),
                backgroundColor: appBarColor,
                pinned: true,
                floating: true,
                actions: [
                  const Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingScreen(
                            userId: userId,
                            userName: userName,
                            userEmail: userEmail,
                            userPassword: userPassword,
                          ),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                ],
                bottom: const TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.groups_rounded),
                    ),
                    Tab(
                      //icon: Icon(Icons.groups_rounded),
                      text: 'Chats',
                    ),
                    Tab(
                      //icon: Icon(Icons.groups_rounded),
                      text: 'Status',
                    ),
                    Tab(
                      // icon: Icon(Icons.groups_rounded),
                      text: 'Calls',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              const GroupScreen(),
              ChatsScreen(
                userId: userId,
                userName: userName,
                userEmail: userEmail,
              ),
              const StatusScreen(),
              const CallScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
