// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:whatsappdemo/screens/calls_page.dart';
import 'package:whatsappdemo/screens/group_page.dart';
import 'package:whatsappdemo/screens/home_page.dart';
import 'package:whatsappdemo/screens/login_register_common_page.dart';
import 'package:whatsappdemo/screens/status_page.dart';

import 'package:whatsappdemo/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: WelcomeScreen(),
      initialRoute: 'Welcome_Screen',
      routes: {
        'Welcome_Screen': (context) => const WelcomeScreen(),
        'Home_Screen': (context) => const HomeScreen(),
        'SignIn_Screen': (context) =>
           const LoginRegisterCommonScreen(textFieldEvent: false),
        'SignUp_Screen': (context) =>
            const LoginRegisterCommonScreen(textFieldEvent: true),
        'Group_Screen': (context) => const GroupScreen(),
        //'Chat_Screen': (context) => const ChatsScreen(),
        'Status_Screen': (context) => const StatusScreen(),
        'Call_Screen': (context) => const CallScreen(),
       // 'Contact_Screen': (context) => const ContactScreen(),
        //'MessageType_Screen': (context) => const MessageTypeScreen(),
      },
    );
  }
}
