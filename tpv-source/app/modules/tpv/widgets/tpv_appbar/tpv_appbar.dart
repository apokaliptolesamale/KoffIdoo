import 'package:flutter/material.dart';

PreferredSizeWidget pdvAppBar() {
  return AppBar(
    title: const Text(
      'Agregar productos al carrito',
      style: TextStyle(
        color: Colors.black,
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {},
          child: const Icon(
            Icons.shopping_cart_checkout,
            color: Colors.black,
          )),
    ],
  );
}
