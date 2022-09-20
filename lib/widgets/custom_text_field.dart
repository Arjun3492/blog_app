import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    required this.validator,
    required this.controller,
  }) : super(key: key);
  final String hint;
  final validator;
  final controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.yellow)),
        child: TextFormField(
          maxLines: 2,
          minLines: 1,
          validator: validator,
          controller: controller,
          decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        ));
  }
}
