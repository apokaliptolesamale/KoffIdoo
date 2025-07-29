import 'package:apk_template/features/chinchal/presentation/widgets/operation_tile.dart';
import 'package:flutter/material.dart';

class OwnerOperationsScreen extends StatelessWidget {
  const OwnerOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appbar de prueba'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 1'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 2'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 3'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Item 4'),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height * 0.22,
              // color: Colors.amber,
              child: Card(
                elevation: 5,
                color: colors.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Icon(Icons.attach_money),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Saldo disponible', style: textTheme.titleMedium,),
                          Text(
                            '\$ XXXXX.XX ',
                            style: textTheme.headlineLarge,
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        
                          children: [
                            Text('NOMBRE DEL COMERCIO', style: textTheme.labelLarge)  ,
                            IconButton(onPressed: (){},icon: const Icon(Icons.visibility_off) ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            SizedBox(
              width: double.infinity,
              height: height * 0.5,
              // color: Colors.blue,
              child: ListView(
                children: [
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Pendiente', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Fallida', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Aceptada', transactionId: 'wqdh65duaywqhdu',),
                  SizedBox(height: height*0.01,),
                  const OperationTile(user: 'Usuario', amount: '254', currency: 'CUP', status: 'Pendiente', transactionId: 'wqdh65duaywqhdu',),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
