import 'dart:math';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe/basedata/basedata.dart';
import 'package:recipe/db/products.dart';

class Dbassistant{
  late Future<Isar> db;

  Dbassistant() {
    db = openDb();
  }

  Basedata baseData = Basedata();

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return Isar.open(
        [
          ProductSchema
        ],
        inspector: true,
        directory: dir.path,
      );
    }

    return Future.value(Isar.getInstance());
  }
  addproduct(String title,String category, String image, int id) async {
    final isar = await db;
    var random = Random();
    var products = await isar.products
        .filter()
        .thidEqualTo(id)
        .findAll();

    if (products.isEmpty) {
      final product = Product()
        ..title = title
        ..category = category
        ..image = image
        ..price = random.nextInt(10000 - 1000) + 1000
        ..thid = id;
      await isar.writeTxn(() async {
        await isar.products.put(product);
      });
    }
  }

  products(String category) async {
    final isar = await db;
    var response = isar.products.filter().categoryEqualTo(category).findAll();
    return response;
  }
}