import 'package:apk_template/features/apk_comercio_experto/data/models/product_model.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/sell_ticket_model.dart';
import 'package:apk_template/features/apk_comercio_experto/domain/entities/entities.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:apk_template/features/apk_comercio_experto/data/models/cash_model.dart';

class SqlLiteDataBase {
  static final SqlLiteDataBase _instance = SqlLiteDataBase._internal();

  factory SqlLiteDataBase() {
    return _instance;
  }

  SqlLiteDataBase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'commerce.db'); // Cambio en el nombre del archivo

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cash (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cantidad INTEGER NOT NULL,
        image_path TEXT NOT NULL,
        valor INTEGER NOT NULL
      )
    ''');
    await db.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      code TEXT NOT NULL,
      qr_code TEXT NOT NULL,
      mark TEXT NOT NULL,
      model TEXT NOT NULL,
      category_name TEXT NOT NULL,
      id_product TEXT NOT NULL,
      id_order_service TEXT NOT NULL,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      short_description TEXT NOT NULL,
      images TEXT NOT NULL, -- Almacena como JSON una lista de URLs
      regula_price REAL NOT NULL,
      sale_price REAL NOT NULL,
      discount INTEGER NOT NULL,
      if_item_aviable INTEGER NOT NULL, -- Usar 0/1 para representar booleanos
      if_added_to_cart INTEGER NOT NULL,
      stock_quantity INTEGER NOT NULL,
      sizes TEXT NOT NULL, -- Almacena como JSON una lista de tamaños
      categories TEXT NOT NULL, -- Almacena como JSON una lista de categorías
      id_warranty TEXT NOT NULL
    )
  ''');
     await db.execute('''
    CREATE TABLE sell_tickets (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      products TEXT NOT NULL, -- Se almacenará como JSON
      total REAL NOT NULL,
      cashpaid REAL NOT NULL,
      date TEXT NOT NULL,
      shopId TEXT NOT NULL,
      clientId TEXT NOT NULL
    )
  ''');
  }
  Future<void> insertSellTicket(SellTicketModel sellTicket) async {
    final db = await database;
    await db.insert(
      'sell_tickets',
      sellTicket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Método para obtener todos los tickets de venta
  Future<List<SellTicketModel>> getSellTickets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sell_tickets');

    return maps.map((map) => SellTicketModel.fromMap(map)).toList();
  }

  // Método para eliminar todos los tickets de venta (cuando se cierra la caja registradora)
  Future<void> clearSellTickets() async {
    final db = await database;
    await db.delete('sell_tickets');
  }
  Future<void> insertCash(CashModel cash) async {
    final db = await database;
    await db.insert('cash', cash.toMap());
  }

  Future<List<CashModel>> getCashList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cash');
    return maps.map((map) => CashModel.fromMap(map)).toList();
  }

  Future<void> updateCash(CashModel cash) async {
    final db = await database;
    await db.update(
      'cash',
      cash.toMap(),
      where: 'valor = ?',
      whereArgs: [cash.valor],
    );
  }
  Future<void> updateCashList(List<CashModel> cashList) async {
  final db = await database;

  await db.transaction((txn) async {
    for (final cash in cashList) {
      await txn.update(
        'cash',
        cash.toMap(),
        where: 'valor = ?',
        whereArgs: [cash.valor],
      );
    }
  });
}

  Future<void> deleteCash(int valor) async {
    final db = await database;
    await db.delete(
      'cash',
      where: 'valor = ?',
      whereArgs: [valor],
    );
  }
//TODO Implementar Metodos reales
  Future<void> insertProduct(ProductModel product) async {
    final db = await database;
    await db.insert('products', product.toJson());
  }

  Future<List<ProductModel>> getProductList() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return maps.map((map) => ProductModel.fromJson(map)).toList();
  }

  Future<void> updateProduct(ProductModel product) async {
    final db = await database;
    await db.update(
      'products',

      //todo Implementar producto real
      product.toJson(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> deleteProduct(int valor) async {
    final db = await database;
    await db.delete(
      'products',
      //todo implementar esto
      where: 'valor = ?',
      whereArgs: [valor],
    );
  }


}
