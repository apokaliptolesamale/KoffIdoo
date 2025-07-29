import 'package:flutter/material.dart';

PreferredSizeWidget mainAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    title: const Text(
      'Punto de Venta',
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const Text(
                'Nombre de la tienda',
                style: TextStyle(color: Colors.black),
              ),
              const Icon(
                Icons.store,
                size: 18,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
