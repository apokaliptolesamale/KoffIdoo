import 'package:flutter/material.dart';

class DescriptionWidget extends StatelessWidget {
  final TextEditingController controllerDesc;
  const DescriptionWidget({key, required this.controllerDesc});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height / 80,
          ),
          TextFormField(
            cursorColor: Colors.grey,
            textAlign: TextAlign.center,
            controller: controllerDesc,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              /* enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none, */
              isDense: true,
              prefixStyle: TextStyle(color: Colors.black),
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(' Descripción  '),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height / 80,
          ),
        ],
      ),
    );
  }
}
