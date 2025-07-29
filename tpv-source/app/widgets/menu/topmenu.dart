// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class TopMenu extends StatefulWidget {
  @override
  _TopMenuState createState() => _TopMenuState();
}

class _TopMenuState extends State<TopMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0.0),
      height: 80.0,
      alignment: Alignment.topCenter,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 6.5,
                    spreadRadius: 1.0,
                    offset: Offset(2.0, 8.0),
                  )
                ],
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
              child: Icon(
                Icons.menu,
                size: 30.0,
                color: Colors.blueGrey,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.8),
                    blurRadius: 6.5,
                    spreadRadius: 1.0,
                    offset: Offset(2.0, 8.0),
                  )
                ],
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Icon(
                Icons.person,
                color: Colors.blueGrey,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
