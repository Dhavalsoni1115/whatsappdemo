import 'package:flutter/material.dart';
import 'package:whatsappdemo/constnts.dart';
import 'package:whatsappdemo/screens/profile_page.dart';
import 'package:whatsappdemo/widgets/list_tile_card.dart';

class SettingScreen extends StatelessWidget {
  final dynamic userId, userName, userEmail,userPassword;
  const SettingScreen({
    Key? key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                    userId: userId, userName: userName, userEmail: userEmail,userPassword:userPassword),
              ),
            ),
            child: ListTileCard(
              listtileTitle: Text(userName),
              listtileSubTitle: const Text(''),
              listtileDate: const Text(''),
              circleAvtarImage: const AssetImage('assets/images/profile.jpg'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const ListTileCard(
            listtileTitle: Text('Account'),
            listtileSubTitle: Text('Security notifications,change number'),
            listtileDate: Text(''),
            circleAvtarChild: Icon(
              Icons.key,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ListTileCard(
            listtileTitle: Text('Privacy'),
            listtileSubTitle: Text('Block contacts,disappearing mesages'),
            listtileDate: Text(''),
            circleAvtarChild: Icon(
              Icons.lock,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ListTileCard(
            listtileTitle: Text('Avtar'),
            listtileSubTitle: Text('Create,edit,profile,photo'),
            listtileDate: Text(''),
            circleAvtarChild: Icon(
              Icons.person,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
