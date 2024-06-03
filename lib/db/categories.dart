import 'package:isar/isar.dart';
part 'categories.g.dart';
@collection
class Categories{
  Id id = Isar.autoIncrement;
  late String name;

  Map<String,dynamic> toJson()=> {
    'id':id.toString(),
    'name': name,
  };
}