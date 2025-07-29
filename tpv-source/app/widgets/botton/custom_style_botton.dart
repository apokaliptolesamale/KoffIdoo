// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomStyleBotton extends StatelessWidget {
  String text;
  CustomStyleBotton({Key? key, required this.text})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(0, 2))
        ],
      ),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.pin,
            color: Color(0xFF307DF1),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              /*isShow = !isShow;
                _runExpandCheck();
                setState(() {});*/
            },
            child: Text(
              text,
              style: TextStyle(color: Color(0xFF307DF1), fontSize: 16),
            ),
          )),
        ],
      ),
    );
  }
}
