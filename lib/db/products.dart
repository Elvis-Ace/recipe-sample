import 'package:isar/isar.dart';
part 'products.g.dart';
@collection
class Product{
  Id id = Isar.autoIncrement;
  late int thid;
  late String title;
  late String category;
  late int price;
  late String image;

}