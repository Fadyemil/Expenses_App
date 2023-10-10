import 'package:flutter/material.dart';

class CustomTextFiledFrom extends StatelessWidget {
  const CustomTextFiledFrom({
    super.key,
    required this.hintText,
    required this.MyController,
    required this.validate,
  });
  final String hintText;
  final TextEditingController MyController;

  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validate,
      controller: MyController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color.fromARGB(255, 144, 142, 142)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Color.fromARGB(255, 145, 143, 143)),
        ),
      ),
    );
  }
}
