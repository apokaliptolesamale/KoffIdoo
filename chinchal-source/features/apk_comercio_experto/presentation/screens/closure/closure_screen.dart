import 'package:flutter/material.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/cash_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/services/sqlite_database.dart';

class CloseCashRegisterPage extends StatefulWidget {
  const CloseCashRegisterPage({Key? key}) : super(key: key);

  @override
  _CloseCashRegisterPageState createState() => _CloseCashRegisterPageState();
}

class _CloseCashRegisterPageState extends State<CloseCashRegisterPage> {
  double totalExpected = 0.0;
  bool _isLoading = false;
  String? _errorMessage;
  TextEditingController countedCashController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _calculateExpectedTotal();
  }

  /// Obtiene el dinero inicial a partir de la tabla 'cash'
  Future<double> _getInitialCash() async {
    double initial = 0.0;
    try {
      List<CashModel> cashList = await SqlLiteDataBase().getCashList();
      for (var cash in cashList) {
        initial += cash.cantidad * cash.valor;
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener caja inicial: $e';
      });
    }
    return initial;
  }

  /// Recorre los sell tickets y calcula el total esperado en caja.
  Future<void> _calculateExpectedTotal() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    double initial = await _getInitialCash();

    double totalCashPaid = 0.0;
    double totalExcess = 0.0;
    try {
      List<SellTicketModel> tickets = await SqlLiteDataBase().getSellTickets();
      for (var ticket in tickets) {
        totalCashPaid += ticket.cashpaid;
        // Si el pago excede el total, se descuenta el exceso (dinero entregado como cambio)
        if (ticket.cashpaid > ticket.total) {
          totalExcess += (ticket.cashpaid - ticket.total);
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener tickets de venta: $e';
      });
    }
    // Total esperado en caja = dinero inicial + efectivo recibido - exceso entregado como cambio.
    double expected = initial + totalCashPaid - totalExcess;
    setState(() {
      totalExpected = expected;
      _isLoading = false;
    });
  }

  /// Limpia los registros de sell tickets y de caja en la base de datos.
  Future<void> _clearRecords() async {
    try {
      // Limpiar sell tickets
      await SqlLiteDataBase().clearSellTickets();
      // Limpiar la tabla cash: elimina todos los registros.
      final db = await SqlLiteDataBase().database;
      await db.delete('cash');
      // Recalcula el total esperado (ahora debería ser 0)
      _calculateExpectedTotal();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al limpiar registros: $e')),
      );
    }
  }

  /// Compara el dinero contado ingresado con el total esperado y muestra la diferencia.
  void _compareCash() {
    double counted = double.tryParse(countedCashController.text) ?? 0.0;
    double difference = counted - totalExpected;

    // Si el dinero cuadra, preguntar si se desean limpiar los registros.
    if (difference == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Dinero Cuadra'),
            content: const Text(
                'El dinero cuadra perfectamente. ¿Desea limpiar los registros de ventas y caja?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    const Text('Cancelar', style: TextStyle(color: Colors.blue)),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _clearRecords();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registros limpiados.')),
                  );
                },
                child:
                    const Text('Aceptar', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    } else {
      // Si no cuadra, mostrar el cambio o la falta.
      String result;
      if (difference > 0) {
        result = 'Cambio: \$${difference.toStringAsFixed(2)}';
      } else {
        result = 'Falta: \$${(-difference).toStringAsFixed(2)}';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Resultado', style: TextStyle(color: Colors.blue)),
            content: Text(
              result,
              style: const TextStyle(fontSize: 16),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child:
                    const Text('OK', style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    }
  }

  /// Permite forzar el cierre de caja sin importar que el dinero no cuadre.
  void _forceCloseRegister() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar Caja Forzado'),
          content: const Text(
              '¿Está seguro que desea cerrar la caja aunque el dinero no cuadre?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _clearRecords();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Caja cerrada forzosamente.')),
                );
              },
              child: const Text('Aceptar', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  /// Muestra detalles de la operación (sell ticket)
  void _showOperationDetails(SellTicketModel ticket) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Detalles de Operación'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fecha: ${ticket.date.toLocal().toString().split(" ")[0]}'),
              Text('Total: \$${ticket.total.toStringAsFixed(2)}'),
              Text('Efectivo recibido: \$${ticket.cashpaid.toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              const Text(
                'Productos consumidos:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              // Lista de productos consumidos
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ticket.products.map((product) {
                  // Se asume que ProductModel tiene 'name', 'quantity' y 'salePrice'
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '${product.name} x${product.quantity} - \$${(product.salePrice * product.quantity).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar', style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    },
  );
}


  @override
  void dispose() {
    countedCashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.go('/home'), icon: const Icon(Icons.home_outlined ,color: Colors.black,)),
        title: const Text('Cerrar Caja'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _calculateExpectedTotal,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  const Text(
                    'Total esperado en caja:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${totalExpected.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Sección para listar las operaciones
                  const Divider(),
                  const Text(
                    'Operaciones',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<SellTicketModel>>(
                      future: SqlLiteDataBase().getSellTickets(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        final operations = snapshot.data ?? [];
                        if (operations.isEmpty) {
                          return const Center(child: Text('No hay operaciones registradas.'));
                        }
                        return ListView.builder(
                          itemCount: operations.length,
                          itemBuilder: (context, index) {
                            final ticket = operations[index];
                            return ListTile(
                              title: Text(
                                  'Operación del ${ticket.date.toLocal().toString().split(" ")[0]}'),
                              subtitle: Text(
                                  'Total: \$${ticket.total.toStringAsFixed(2)} | Efectivo: \$${ticket.cashpaid.toStringAsFixed(2)}'),
                              trailing: ElevatedButton(
                                onPressed: () => _showOperationDetails(ticket),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                child: const Text('Comprobar'),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Campo para ingresar dinero contado
                  TextField(
                    controller: countedCashController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Dinero contado',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _compareCash,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          'Comparar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _forceCloseRegister,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text(
                          'Cerrar Caja (Forzado)',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
