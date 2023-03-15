import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final String labelName;
  final bool obscureText;
  final dynamic onChange, validator;
  const CommonTextField({
    Key? key,
    required this.labelName,
    required this.onChange,
    required this.validator,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 30, left: 30),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(labelName),
        ),
        onChanged: onChange,
        validator: validator,
      ),
    );
  }
}
