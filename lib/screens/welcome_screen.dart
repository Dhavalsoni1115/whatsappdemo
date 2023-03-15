import 'package:flutter/material.dart';
import 'package:whatsappdemo/widgets/common_button.dart';
import 'package:whatsappdemo/widgets/logo_container.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const LogoContainer(),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              "Welcome to WhatsApp",
              style: TextStyle(fontSize: 20, color: Colors.green.shade900),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
            child: CommonButton(
                onTap: () {
                  setState(() {
                    Navigator.pushNamed(context, 'SignIn_Screen');
                  });
                },
                buttonName: 'Sign In'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: CommonButton(
              onTap: () {
                setState(() {
                  Navigator.pushNamed(context, 'SignUp_Screen');
                });
              },
              buttonName: 'Sign Up',
            ),
          ),
        ],
      ),
    );
  }
}
