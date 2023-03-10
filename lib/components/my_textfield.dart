import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
final controller;
final String hintText;
final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(189, 189, 189, 1)),
                    ),
                    fillColor: Color.fromRGBO(238, 238, 238, 1),
                    filled:true,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.grey[500])
                  ),
                ),
              );
  }

}