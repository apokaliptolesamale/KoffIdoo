import 'package:flutter/material.dart';

// class WaitingWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CircularProgressIndicator(),
//         SizedBox(height: 10),
//         Text('Esperando respuesta del servidor...')
//       ],
//     );
//   }
// }
class WaitingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:
          Colors.black.withOpacity(0.01), // Fondo casi transparente
      elevation: 58.0, // Efecto de elevación
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Esperando respuesta del servidor...')
        ],
      ),
    );
  }
}
