import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';

import 'package:apk_template/features/apk_comercio_experto/presentation/providers/product_provider.dart';

import 'package:apk_template/features/chinchal/presentation/widgets/blue_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/shopping_cart_provider.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Nunca BORRAR ESTO ES LO Q ACTUALIZA LA CANTIDAD DE PRODUCTOS EN EL CARRITO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // ignore: unused_local_variable
    final cartP = ref.watch(shoppingCartProvider);
    final productsP = ref.watch(productProvider);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            const FondoAzul(),
            _GridProducts(products: productsP.products)
          ],
        ),
      ),
    );
  }
}

class _GridProducts extends StatefulWidget {
  const _GridProducts({
    required this.products,
  });

  final List<ProductModel> products;

  @override
  State<_GridProducts> createState() => _GridProductsState();
}

class _GridProductsState extends State<_GridProducts> {
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.sizeOf(context).height * 0.3),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return _ProductCard(
          product: widget.products[index],
          ontap: () {
            setState(() {});
          },
        );
      },
    ));
  }
}

class _ProductCard extends ConsumerWidget {
  const _ProductCard({
    required this.ontap,
    required this.product,
  });
  final Function() ontap;
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final cartProvider = ref
        .watch(shoppingCartProvider); // Obtener acceso al controlador

    return GestureDetector(
      onTap: () {
        cartProvider.addToCart(product); // Agregar el producto al carrito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('${product.name} añadido al carrito')),
            duration: const Duration(milliseconds: 200),
            backgroundColor: const Color.fromARGB(255, 76, 172, 175),
          ),
        );
        ontap();
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Encabezado del producto
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  product.description ?? '',
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Imagen del producto
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 80,
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/loading.gif'),
                      image: NetworkImage(product.images.first),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // Precio del producto
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'Precio: ${(product.salePrice * product.discount).toStringAsFixed(2)} CUP',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 4),
                    if (cartProvider.listOfProducts.contains(product))
                    
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Text(
                          cartProvider.listOfProducts.where((element) => product.idProduct == element.idProduct,).first.quantity.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
