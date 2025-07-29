import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/repositories/sell_ticket_repository_impl.dart';
import 'package:apk_template/features/apk_comercio_experto/data/repositories/shopping_cart_repository_impl.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/sell_tickets_repository.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/repository/shoping_cart_repository.dart';

import '../../data/datasources/sell_ticket_datasource_impl.dart';
import '../../data/datasources/shopping_cart_datasource_impl.dart';

final shoppingCartDatasourceProvider =
    Provider<ShoppingCartDatasourceImpl>((ref) => ShoppingCartDatasourceImpl());

final shoppingCartLocalRepositoryProvider =
    Provider<ShoppingCartRepositoryImpl>((ref) => ShoppingCartRepositoryImpl(
        shoppingCartDatasource: ref.watch(shoppingCartDatasourceProvider)));

final sellTicketDatasource =
    Provider<SellTicketsDatasourceImpl>((ref) => SellTicketsDatasourceImpl());

final sellTicketsRepository = Provider<SellTicketRepositoryImpl>((ref) =>
    SellTicketRepositoryImpl(
        sellTicketsDatasource: ref.watch(sellTicketDatasource)));

final shoppingCartProvider = ChangeNotifierProvider(
  (ref) {
    final shoppingProvider = ref.watch(shoppingCartLocalRepositoryProvider);
    final sellTicketRepository = ref.watch(sellTicketsRepository);
    return ShoppingCartProvider(
        shoppingCartRepository: shoppingProvider,
        sellTicketRepository: sellTicketRepository);
  },
);

class ShoppingCartProvider extends ChangeNotifier {
  final ShoppingCartRepository shoppingCartRepository;
  final SellTicketsRepository sellTicketRepository;

  List<ProductModel> listOfProducts = [];
  List<SellTicketModel> _salesHistory = [];

  ShoppingCartProvider({
    required this.shoppingCartRepository,
    required this.sellTicketRepository,
  });

  Future<void> startShopping() async {
    try {
      listOfProducts = await shoppingCartRepository.initailizeCart();
    } catch (e) {
      listOfProducts = [];
    } finally {
      notifyListeners();
    }
  }

  void incrementProduct(ProductModel product) {
    product.quantity++;
    notifyListeners();
  }

  void decrementProduct(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity--;
    } else {
      listOfProducts.remove(product);
    }
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    final existingProduct = listOfProducts.firstWhereOrNull(
      (p) => p.id == product.id,
    );
    if (existingProduct != null) {
      incrementProduct(existingProduct);
    } else {
      product.quantity = 1; // Asegura que un nuevo producto tenga cantidad 1
      listOfProducts.add(product);
    }
    notifyListeners();
  }

  Future<void> sellProduct(double? totalPaid) async {
    if (listOfProducts.isEmpty) {
      throw Exception("El carrito está vacío, no se puede realizar la venta");
    }

    final sellTicket = SellTicketModel(
      date: DateTime.now(),
      products: List.from(listOfProducts),
      total: listOfProducts.fold(
          0.0,
          (total, product) =>
              total + (product.salePrice * product.quantity)),
      cashpaid: totalPaid ?? calculateTotal(),
      clientId: '',
      shopId: '',
    );

    try {
      // Guarda el ticket de venta en la BD
      await postTicket(sellTicket);

      // Genera el recibo en PDF y lo guarda en el dispositivo
      final receiptFile = await generateReceipt(sellTicket);
      debugPrint('Recibo generado en: ${receiptFile.path}');

      // Limpia el carrito
      listOfProducts = [];
      notifyListeners();
    } catch (e) {
      debugPrint('Error al realizar la venta: $e');
      throw 'Error al procesar la venta';
    }
  }

  Future<void> postTicket(SellTicketModel sellTicket) async {
    try {
      await sellTicketRepository.postSellTicket(sellTicket);
      _salesHistory.add(sellTicket);
      notifyListeners();
    } catch (e) {
      debugPrint('Error al guardar el ticket: $e');
      throw 'Error al guardar el ticket de venta';
    }
  }

  /// Devuelve el último ticket de venta.
  Future<SellTicketModel> getTicket() async {
    try {
      if (_salesHistory.isNotEmpty) {
        return _salesHistory.last;
      }
      final tickets = await sellTicketRepository.getSellTicket();
      if (tickets.isNotEmpty) {
        return tickets.last;
      }
      throw Exception("No hay tickets disponibles");
    } catch (e) {
      debugPrint('Error al obtener el ticket: $e');
      throw 'Error al recuperar el ticket de venta';
    }
  }

  /// Nuevo método: devuelve la lista completa de tickets de venta.
  Future<List<SellTicketModel>> getSellTickets() async {
    try {
      if (_salesHistory.isNotEmpty) {
        return _salesHistory;
      }
      final tickets = await sellTicketRepository.getSellTicket();
      return tickets;
    } catch (e) {
      debugPrint('Error al obtener los tickets: $e');
      throw 'Error al recuperar los tickets de venta';
    }
  }

  Future<void> clearTickets() async {
    try {
      await sellTicketRepository.clearTickets();
      _salesHistory.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error al limpiar los tickets: $e');
      throw 'Error al limpiar los tickets';
    }
  }

  double calculateTotal() {
    return listOfProducts.fold(
        0, (total, product) => total + (product.salePrice * product.quantity));
  }

  /// Función que genera el PDF del recibo y lo guarda en el almacenamiento temporal.
  Future<File> generateReceipt(SellTicketModel ticket) async {
    final pdf = pw.Document();

    // Construimos el contenido del recibo
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Recibo de Venta',
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Fecha: ${ticket.date.toIso8601String()}'),
              pw.Text('Tienda: ${ticket.shopId}'),
              pw.Text('Cliente: ${ticket.clientId}'),
              pw.SizedBox(height: 20),
              pw.Text('Productos:', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
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
              pw.Text('Efectivo Recibido: \$${ticket.cashpaid.toStringAsFixed(2)}'),
            ],
          );
        },
      ),
    );

    // Obtenemos el directorio temporal y guardamos el archivo
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/recibo_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
