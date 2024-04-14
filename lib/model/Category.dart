import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanager/model/Recipe.dart';

class Category {
  late String id;
  late String name;
  late String imgUrl;
  List<Recipe>? recipes;
  List<String>? readers;
  List<String>? editors;
  String? owner;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.recipes,
    this.readers,
    this.editors,
    this.owner,
    this.createdAt,
    this.updatedAt,
  });
}
