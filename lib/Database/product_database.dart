import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class ProductDatabase {
  static Database? productDatabase;

  Future setProductDatabase() async {
    try {
      final db = await openDatabase(
        path.join(await getDatabasesPath(), 'Product.db'),
        version: 1,
      );
      return db;
    } catch (e) {
      print("Database setProductDatabase ${e.toString()}");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getRowInList(int id) async {
    productDatabase = await setProductDatabase();
    return await productDatabase!
        .rawQuery("SELECT * FROM Product WHERE id = '${id}'");
  }

  Future<List<Map>> getTableInList() async {
    productDatabase = await setProductDatabase();
    return await productDatabase!.rawQuery('SELECT * FROM Product');
  }

  setDatabase() async {
    try {
      productDatabase = await setProductDatabase();
      await productDatabase!.execute(
          "CREATE TABLE IF NOT EXISTS 'Product' (id Text  PRIMARY KEY , name Text , image Text, description Text, costPerLaunch INTEGER, country Text, engine_count INTEGER, active INTEGER, successRatePct INTEGER, wikipedia Text, height_feet FLOAT, height_meters FLOAT, diameter_feet FLOAT, diameter_meters FLOAT)");
      return;
    } catch (e) {
      print("Database setDatabase ${e.toString()}");
      return;
    }
  }
}
