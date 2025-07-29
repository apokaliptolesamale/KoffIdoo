// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class IdClientSearch extends StatefulWidget {
  BuildContext bcontext;
  IdClientSearch({Key? key, required this.bcontext});

  @override
  State<IdClientSearch> createState() => _IdClientSearchState();
}

class _IdClientSearchState extends State<IdClientSearch> {
  TextEditingController controllerIdClient = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controllerIdClient,
              onChanged: (value) {
                value = controllerIdClient.text;
              },
              decoration: InputDecoration(
                hintText: "Id Cliente",
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          TextButton(
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Aceptar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        color: Colors.white),
                  ),
                ),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            // color: Colors.red,
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Card(
              elevation: 2,
              child: ListView(
                children: [
                  Text(
                    "Mis Id Cliente",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView(
                        children: [],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
