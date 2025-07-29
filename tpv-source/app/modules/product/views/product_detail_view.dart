// ignore_for_file: must_be_immutable, unnecessary_null_comparison, library_private_types_in_public_api, unused_element

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/core/constants/enums.dart';
import '/app/core/services/logger_service.dart';
import '/app/modules/product/domain/models/product_model.dart';
import '/app/modules/product/domain/models/role_model.dart';
import '/app/modules/product/domain/usecases/update_product_usecase.dart';
import '/app/modules/product/widgets/product_information_tabbar.dart';
import '/app/modules/product/widgets/product_scanneable_edit_form.dart';
import '/app/widgets/images/custom_image_source.dart';
import '/app/widgets/layout/card/empty_card.dart';
import '/app/widgets/menu/custom_menu_text_list.dart';
import '/app/widgets/utils/size_constraints.dart';

class ProductDetailView extends StatefulWidget {
  final List<ProductModel> _products;
  int defaultIndex;
  final GlobalViewMode viewMode;
  ProductDetailView({
    Key? key,
    required List<ProductModel> products,
    required this.defaultIndex,
    this.viewMode = GlobalViewMode.visible,
  })  : _products = products,
        super(key: key);

  @override
  _ProducDetailState createState() => _ProducDetailState();
}

class _ProducDetailState extends State<ProductDetailView>
    with TickerProviderStateMixin {
  int defaultIndex = 0;
  late GlobalViewMode viewMode;
  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (ctx, constraint) {
          final size = SizeConstraints(context: ctx);
          return Container(
            padding: EdgeInsets.only(bottom: size.getHeightByPercent(17)),
            constraints: constraint,
            color: Colors.transparent,
            width: double.infinity,
            height: constraint.constrainHeight(size.getHeightByPercent(100)),
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                final product = widget._products.elementAt(index);
                return _buildProductDetailsPage(ctx, constraint, product);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 5,
                );
              },
              itemCount: widget._products.length,
            ),
          );
        },
      ),
    );
  }

  @override
  initState() {
    viewMode = widget.viewMode;
    defaultIndex = widget.defaultIndex;
    tabController = TabController(
      length: 3, //isTransportista || isCliente ? 2 : 3,
      vsync: this,
      animationDuration: Duration(milliseconds: 1000),
      initialIndex: defaultIndex,
    );
    super.initState();
  }

  onTabChange() {
    setState(() {
      defaultIndex = tabController.index;
    });
  }

  _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: ElevatedButton(
              onPressed: () {},
              //color: Colors.grey,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Guardar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.greenAccent)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.card_travel,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Agregar al carrito",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildDetailsAndMaterialWidgets(ProductModel prod) {
    if (tabController != null) {
      //bool isTransportista = RoleModel.instance.isTransportista();
      //bool isCliente = RoleModel.instance.isCliente();
      tabController.addListener(onTabChange);
      return ProductTabInformation(
        tabController: tabController,
        product: prod,
      );
    }
    return null;
  }

  _buildDivider(Size screenSize) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[600],
          width: screenSize.width,
          height: 0.25,
        ),
      ],
    );
  }

  _buildFurtherInfoWidget(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          /* Icon(
            Icons.local_offer,
            color: Colors.grey[500],
          ),
          SizedBox(
            width: 12.0,
          ),
          //Formulario para escaneo de datos de los productos
          Text(
            "Toca para obtener más información",
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),*/
          Expanded(
            child: ProductScanneableCustomForm(
                mode: viewMode,
                product: product,
                onPressed: (form) {
                  if (form.isValid()) {
                    final uc = Get.find<UpdateProductUseCase>();
                    uc.setParamsFromMap(form.getData()).call(null);
                  }
                }),
          )
        ],
      ),
    );
  }

  _buildMoreInfoData(ProductModel product) {
    switch (defaultIndex) {
      case 0: //Notas de la Garantía
        return _moreInfoForWarranty(product);
      case 1: //Notas del Producto
        return _moreInfoForProduct(product);
      case 2: //Notas del Beneficiario
        return _moreInfoForBeneficiary(product);
      default:
        return Container();
    }
  }

  _buildMoreInfoHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Más información",
        style: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildPriceWidgets(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "\$${product.salePrice}",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "\$${product.regularPrice}",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            "${product.discount}% Descuento",
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetailsPage(
    BuildContext context,
    BoxConstraints constraint,
    ProductModel product,
  ) {
    Size screenSize = MediaQuery.of(context).size;
    Widget? detail = _buildDetailsAndMaterialWidgets(product);
    return Container(
      constraints: constraint,
      padding: const EdgeInsets.all(4.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildProductImagesWidgets(product),
            _buildProductTitleWidget(product),
            SizedBox(height: 12.0),
            if (RoleModel.instance.isCliente()) ...[
              _buildPriceWidgets(product),
              SizedBox(height: 12.0)
            ],
            _buildDivider(screenSize),
            SizedBox(height: 12.0),
            if (RoleModel.instance.isTransportista() ||
                RoleModel.instance.isDependiente()) ...[
              _buildFurtherInfoWidget(product),
              SizedBox(height: 12.0)
            ],
            _buildDivider(screenSize),
            SizedBox(height: 12.0),
            if (product.size.isNotEmpty) ...[
              _buildSizeChartWidgets(),
              SizedBox(height: 12.0)
            ],
            if (detail != null) detail,
            SizedBox(height: 12.0),
            _buildStyleNoteHeader(),
            SizedBox(height: 6.0),
            _buildDivider(screenSize),
            SizedBox(height: 4.0),
            _buildStyleNoteData(product),
            SizedBox(height: 20.0),
            _buildMoreInfoHeader(),
            SizedBox(height: 6.0),
            _buildDivider(screenSize),
            SizedBox(height: 4.0),
            _buildMoreInfoData(product),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  _buildProductImagesWidgets(ProductModel product) {
    TabController? imagesController = product.images.isNotEmpty
        ? TabController(length: product.images.length, vsync: this)
        : null;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 250.0,
        child: Center(
          child: DefaultTabController(
            length: product.images.length,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: [
                    CarouselSlider(
                      items: product.images.map(
                        (image) {
                          return CustomImageResource.buildFromUrl(
                            context,
                            image.imageURL,
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.50,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        onPageChanged: (index, reason) {
                          log("Cambio de imagen en carrusel");
                        },
                        onScrolled: (value) {},
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        viewportFraction: 0.95,
                      ),
                    )
                  ],
                ),
                /*TabBarView(
                  controller: imagesController,
                  children: product.images.map(
                    (image) {
                      return CustomImageResource.buildFromUrl(image.imageURL);
                    },
                  ).toList(),
                ),*/
                if (imagesController != null)
                  Container(
                    alignment: FractionalOffset(0.5, 0.95),
                    child: TabPageSelector(
                      controller: imagesController,
                      selectedColor: Colors.grey,
                      color: Colors.white,
                    ),
                  )
                else
                  Center(
                    child: EmptyDataCard(
                      margin: EdgeInsets.only(top: 20),
                      width: 150,
                      height: 150,
                      text: "Producto sin imagen",
                      onPressed: () {},
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildProductTitleWidget(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Center(
        child: Text(
          //name,
          product.name,
          style: TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  _buildSizeChartWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.straighten,
                color: Colors.grey[600],
              ),
              SizedBox(
                width: 12.0,
              ),
              Text(
                "Tamaño",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          Text(
            "Tamaño del cuadro",
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }

  _buildStyleNoteData(ProductModel product) {
    switch (defaultIndex) {
      case 0: //Notas de la Garantía
        return _noteForWarranty(product);
      case 1: //Notas del Producto
        return _noteForProduct(product);
      case 2: //Notas del Beneficiario
        return _noteForBeneficiary(product);
      default:
        return Container();
    }
  }

  _buildStyleNoteHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12.0,
      ),
      child: Text(
        "Nota",
        style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _moreInfoForBeneficiary(ProductModel product) {
    return Container();
  }

  Widget _moreInfoForProduct(ProductModel product) {
    final merchantUrl = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("merchantUrl")
        ? product.getOrderPayLoad['merchantUrl']
        : "Desconocido";
    final orden = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("idOrder")
        ? product.getOrderPayLoad['idOrder']
        : "Desconocido";
    final ordenState = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("status")
        ? product.getOrderPayLoad['status']
        : "Desconocido";
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
        ),
        child: CustomMenuTextList(
          title:
              "Información del producto adquirido, datos de la orden de compra, entidad comercial.\n\n",
          menu: {
            "Adquirido en: ": merchantUrl,
            "No. de orden de compra: ": orden,
            "Estado de la orden: ": ordenState,
            "Tiempo de garantía: ": product.warrantyTime.toString()
          },
        ),
      ),
    );
  }

  Widget _moreInfoForWarranty(ProductModel product) {
    final merchantUrl = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("merchantUrl")
        ? product.getOrderPayLoad['merchantUrl']
        : "Desconocido";
    final orden = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("idOrder")
        ? product.getOrderPayLoad['idOrder']
        : "Desconocido";
    final ordenState = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("status")
        ? product.getOrderPayLoad['status']
        : "Desconocido";
    final menuInfo = CustomMenuTextList(
      title:
          "Información de la garantía sobre sus Términos y Condiciones, Tiempo de Garantía y Información del servicio de post venta.\n\n",
      menu: {
        "Adquirido en: ": merchantUrl,
        "No. de orden de compra: ": orden,
        "Estado de la orden: ": ordenState,
        "Tiempo de garantía: ": product.warrantyTime.toString()
      },
    );
    if (product.getWarrantyPayLoad.isEmpty) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
          ),
          child: menuInfo,
        ),
      );
    }
    return Container(
      //TODO agregar la información detallada de la garantía
      child: Text(
          "Información de la garantía: Términos y Condiciones, Tiempo de Garantía, Información del servicio de post venta"),
    );
  }

  Widget _noteForBeneficiary(ProductModel product) {
    return Container();
  }

  Widget _noteForProduct(ProductModel product) {
    final pin = product.getOrderPayLoad.isNotEmpty &&
            product.getOrderPayLoad.containsKey("pin")
        ? product.getOrderPayLoad['pin']
        : "";
    RoleModel.instance.isCliente();
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
        ),
        child: Text.rich(
          TextSpan(
              text:
                  "El producto podrá ser entregado solo al cliente que efectuó la compra, al beneficiario declarado o a cualquier persona portadora del QR del producto. La orden de entrega y el proceso de garantía en general sólo pueden cerrarse previa aceptación del cliente mediante la entrega al transportista/funcionario del PIN de la orden.\n\n",
              children: [
                if (RoleModel.instance.isCliente())
                  TextSpan(
                    text: "PIN: ",
                    children: [
                      TextSpan(
                          text: pin,
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ]),
        ),
      ),
    );
  }

  Widget _noteForWarranty(ProductModel product) {
    String note =
        "Información de la garantía sobre sus Términos y Condiciones, Tiempo de Garantía y Información del servicio de post venta.";
    if (product.getWarrantyPayLoad.isNotEmpty) {
      note = "Poner la nota de la garantía";
    }
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
        ),
        child: Text(note),
      ),
    );
  }
}
