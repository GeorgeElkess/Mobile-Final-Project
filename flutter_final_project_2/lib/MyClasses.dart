// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {super.key,
      this.TextControler,
      this.PlaceHolder = "",
      this.OnTextChange,
      this.InputType,
      this.autoCorrect = false});
  var OnTextChange = null;
  bool autoCorrect = false;
  String PlaceHolder = "";
  TextEditingController? TextControler = null;
  TextInputType? InputType = TextInputType.emailAddress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: // EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
          EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 20, 0),
          child: TextField(
            autocorrect: autoCorrect,
            onChanged: OnTextChange,
            style: const TextStyle(color: Colors.white),
            controller: TextControler,
            decoration: InputDecoration(
              labelText: PlaceHolder,
              labelStyle:
                  const TextStyle(color: Color.fromARGB(255, 154, 200, 237)),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(0, 218, 218, 218),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(0, 218, 218, 218),
                  width: 1,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(4.0),
                ),
              ),
            ),
            keyboardType: InputType,
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.Lable,
      this.OnClick,
      this.thisColor = const Color.fromARGB(100, 75, 57, 239)});
  String Lable = "";
  // ignore: prefer_typing_uninitialized_variables
  final OnClick;
  Color thisColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: // EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
            EdgeInsets.zero,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: thisColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: ElevatedButton(
            onPressed: OnClick,
            style: ElevatedButton.styleFrom(
                backgroundColor: thisColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                )),
            child: Text(Lable),
          ),
        ));
  }
}
