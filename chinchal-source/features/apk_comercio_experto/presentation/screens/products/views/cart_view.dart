import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

import '../../../../../../config/router/app_router.dart';
import '../../../../../chinchal/domain/models/qr_code_model.dart';
import '../../../../../chinchal/presentation/providers/merchant_provider.dart';
import '../../../../data/models/sell_ticket_model.dart';
import '../../../providers/shopping_cart_provider.dart';

/// Función que genera el PDF del recibo y devuelve los bytes.
Future<Uint8List> generateReceiptPdf(SellTicketModel ticket) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Recibo de Venta',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Fecha: ${ticket.date.toIso8601String()}'),
            pw.Text('Tienda: ${ticket.shopId}'),
            pw.Text('Cliente: ${ticket.clientId}'),
            pw.SizedBox(height: 20),
            pw.Text('Productos:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: ticket.products.map((product) {
                return pw.Text(
                  '${product.name} x${product.quantity} - \$${(product.salePrice * product.quantity).toStringAsFixed(2)}',
                  style: const pw.TextStyle(fontSize: 12),
                );
              }).toList(),
            ),
            pw.Divider(),
            pw.Text('Total: \$${ticket.total.toStringAsFixed(2)}'),
            pw.Text(
                'Efectivo Recibido: \$${ticket.cashpaid.toStringAsFixed(2)}'),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

/// Función que guarda el PDF en el almacenamiento local y devuelve el archivo.
Future<File> saveReceiptPdf(SellTicketModel ticket) async {
  final pdfBytes = await generateReceiptPdf(ticket);
  final output = await getApplicationDocumentsDirectory();
  final file = File(
      "${output.path}/recibo_${DateTime.now().millisecondsSinceEpoch}.pdf");
  await file.writeAsBytes(pdfBytes);
  return file;
}

/// Widget que muestra los detalles del ticket de venta.
class SaleDetailsWidget extends StatelessWidget {
  final SellTicketModel ticket;
  const SaleDetailsWidget({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Fecha: ${ticket.date.toLocal().toString().split(' ')[0]}",
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text("Total: \$${ticket.total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text("Efectivo Recibido: \$${ticket.cashpaid.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          const Text("Productos:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...ticket.products.map((product) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  "${product.name} x${product.quantity} - \$${(product.salePrice * product.quantity).toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 14),
                ),
              )),
        ],
      ),
    );
  }
}

/// Función para finalizar la venta: obtiene el ticket, guarda el PDF, muestra un SnackBar
/// y luego presenta un diálogo con los detalles de la venta.
Future<void> finalizeSale(
    BuildContext context, ShoppingCartProvider cartProvider) async {
  final ticket = await cartProvider.getTicket();
  final file = await saveReceiptPdf(ticket);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Recibo guardado en: ${file.path}')),
  );
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Recibo de Venta"),
        content: SaleDetailsWidget(ticket: ticket),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar", style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    },
  );
}

class CartView extends ConsumerWidget {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    // Consumir el ShoppingCartProvider
    final cartProvider = ref.watch(shoppingCartProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Lista de productos en el carrito
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: cartProvider.listOfProducts.isEmpty
                    ? const Center(
                        child: Text(
                          'Tu carrito está vacio!',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartProvider.listOfProducts.length,
                        itemBuilder: (context, index) {
                          final product = cartProvider.listOfProducts[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Imagen del producto
                                  Card(
                                    elevation: 2,
                                    child: FadeInImage(
                                      placeholder: const AssetImage(
                                          'assets/images/loading.gif'),
                                      image: NetworkImage(product.images.first),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  // Detalles del producto
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            product.description ??
                                                'No description',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '\$${(product.salePrice * product.quantity).toStringAsFixed(2)}',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Controles de cantidad
                                  Container(
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cartProvider
                                                .decrementProduct(product);
                                          },
                                          icon: const Icon(
                                              Icons.remove_circle_outline),
                                          color: Colors.red,
                                        ),
                                        Text(
                                          '${product.quantity}',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cartProvider
                                                .incrementProduct(product);
                                          },
                                          icon: const Icon(
                                              Icons.add_circle_outline),
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            // Sección para listar operaciones (sell tickets)

            const SizedBox(height: 16),
            // Botones para realizar la venta
            SizedBox(
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón para venta en efectivo

                  RawMaterialButton(
                      fillColor: colors.primary,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.sizeOf(context).height * 0.17,
                        minWidth: MediaQuery.sizeOf(context).width * 0.21,
                      ),
                      onPressed: () async {
                        final parentContext = context;
                        showDialog(
                          context: parentContext,
                          builder: (context) {
                            final TextEditingController amountController =
                                TextEditingController();
                            final GlobalKey<FormState> formKey =
                                GlobalKey<FormState>();
                            double? diferencia;
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return SimpleDialog(
                                  title: const Text("Ingresar Pago"),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              controller: amountController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                labelText: "Total Pagado",
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) {
                                                double? totalIngresado =
                                                    double.tryParse(value);
                                                if (totalIngresado != null) {
                                                  double totalProducto =
                                                      cartProvider
                                                          .calculateTotal();
                                                  double diff = totalIngresado -
                                                      totalProducto;
                                                  setState(() {
                                                    diferencia =
                                                        diff > 0 ? diff : null;
                                                  });
                                                } else {
                                                  setState(() {
                                                    diferencia = null;
                                                  });
                                                }
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Ingrese un valor";
                                                }
                                                if (double.tryParse(value) ==
                                                    null) {
                                                  return "Ingrese un número válido";
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            if (diferencia != null)
                                              Text(
                                                "Cambio: \$${diferencia!.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.green),
                                              ),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancelar"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      double totalPaid =
                                                          double.parse(
                                                              amountController
                                                                  .text);
                                                      await cartProvider
                                                          .sellProduct(
                                                              totalPaid);
                                                      Navigator.of(
                                                              parentContext)
                                                          .pop();
                                                      // Finalizar venta: guardar PDF y mostrar detalles
                                                      await finalizeSale(
                                                          parentContext,
                                                          cartProvider);
                                                    }
                                                  },
                                                  child:
                                                      const Text("Confirmar"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 10.0)
                        ],
                        Icons.monetization_on_outlined,
                        size: MediaQuery.sizeOf(context).height * 0.07,
                        color: Colors.white,
                      )),

                  Text(
                    'Total: ${NumberFormat.currency(locale: 'en_US', symbol: "\$").format(cartProvider.calculateTotal())}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors
                          .black87, // Color oscuro pero no completamente negro
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Botón para venta por transferencia (QR)
                  RawMaterialButton(
                      fillColor: colors.primary,
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.sizeOf(context).height * 0.17,
                        minWidth: MediaQuery.sizeOf(context).width * 0.21,
                      ),
                      
                      onPressed: () async {
                         final parentContext = context;
                        
                        final total = cartProvider.calculateTotal();
                        final numberFormat = NumberFormat.currency(
                            locale: 'en_US', symbol: "\$");
                        final merchantSelected =
                            ref.read(merchantSelectedProvider);
                        if (cartProvider.listOfProducts.isNotEmpty) {
                          showDialog(
                            barrierDismissible: false,
                            context: parentContext,
                            builder: (context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                          AddQrCodeModel model = AddQrCodeModel(
                            amount: total.toString(),
                            currency: merchantSelected!.moneda,
                            merchantUuid: merchantSelected.uuid,
                            returnUrl:
                                'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=completed-$total',
                            notifyUrl:
                                'https://nyfycore.enzona.net/ntfy/payment-merchant?user=m${merchantSelected.uuid}&message=scaned',
                          );
                          final qrCodeModel =
                              await ref.read(addQrCodeProvider(model).future);
                          if (qrCodeModel != null) {
                            log(qrCodeModel.toJson().toString());
                            ref.read(goRouterProvider).pop();
                            ref.read(goRouterProvider).pushNamed(
                              'DynamicQrCode',
                              pathParameters: {
                                'amount': numberFormat.format(total),
                                'image': qrCodeModel.image!,
                                'qrcode': qrCodeModel.qrCode!,
                              },
                            ).then((value) {
                              // Después de finalizar el proceso QR, mostrar diálogo de confirmación
                              showDialog(
                                context:parentContext ,
                                builder: (context) {
                                  return AlertDialog(
      title: const Text("Confirmación de Compra"),
      content: const Text("¿La compra fue exitosa?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            // Ejecutar venta para transferencia (no se ingresa pago manualmente)
            await cartProvider.sellProduct(null);
            await finalizeSale( parentContext , cartProvider);
          },
          child: const Text("Sí"),
        ),
      ],
    );
                                },
                              );
                            });
                          }
                        } else {
                          ref.read(goRouterProvider).pushNamed(
                            'DynamicQrCode',
                            pathParameters: {
                              'amount': null.toString(),
                              'image': 'apkenzona/assets/ez.png',
                              'qrcode': merchantSelected!.receiveCode!
                            },
                          );
                        }
                      },
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        shadows: const [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 10.0)
                        ],
                        Icons.qr_code_2,
                        size: MediaQuery.sizeOf(context).height * 0.07,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void _showOperationDetails(BuildContext context, SellTicketModel ticket) {
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
                Text(
                    'Fecha: ${ticket.date.toLocal().toString().split(" ")[0]}'),
                Text('Total: \$${ticket.total.toStringAsFixed(2)}'),
                Text(
                    'Efectivo recibido: \$${ticket.cashpaid.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                const Text('Productos consumidos:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ticket.products.map((product) {
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
}

class _EndShoppingDialog extends StatelessWidget {
  const _EndShoppingDialog({Key? key, required this.cartProvider})
      : super(key: key);
  final ShoppingCartProvider cartProvider;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirmación de Compra"),
      content: const Text("¿La compra fue exitosa?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            // Ejecutar venta para transferencia (no se ingresa pago manualmente)
            await cartProvider.sellProduct(null);
            await finalizeSale(context, cartProvider);
          },
          child: const Text("Sí"),
        ),
      ],
    );
  }
}
