import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/cash_entity.dart';

import '../../providers/cash_provider.dart';

class ApertureScreen extends ConsumerWidget {
  const ApertureScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashNotifier = ref.watch(cashProvider);
    final cashList = cashNotifier.cash;
    final total = cashNotifier.calculateTotal();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text('Apertura de Caja'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cashList.length,
                itemBuilder: (context, index) {
                  final billete = cashList[index];
                  return _CashItem(
                    billete: billete,
                    onValueChanged: (value) {
                      cashNotifier.updateCash(index, value);
                    },
                  );
                },
              ),
            ),
            Container(
              color: Colors.lightBlue[100],
              height: 60,
              alignment: Alignment.center,
              child: Text(
                'Total: $total CUP',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CashItem extends StatelessWidget {
  const _CashItem({
    super.key,
    required this.billete,
    required this.onValueChanged,
  });

  final CashEntity billete;
  final ValueChanged<int> onValueChanged;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: billete.cantidad.toString());

    return Card(
      child: ListTile(
        leading: RotatedBox(
          quarterTurns: -1,
          child: Image.asset(
            billete.imagePath,
            width: 50,
            height: 50,
          ),
        ),
        title: Text('${billete.valor} CUP'),
        trailing: SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(labelText: 'Cantidad'),
            onSubmitted: (value) {
              final int cantidad = int.tryParse(value) ?? 0;
              onValueChanged(cantidad);
            },
          ),
        ),
      ),
    );
  }
}
