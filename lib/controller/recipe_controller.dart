// Inside recipe_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Recipe.dart'; // Adjust the import path as necessary

class RecipeController {
  Future<List<Recipe>> fetchRecipesByCategoryId(String categoryId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('categoryId', isEqualTo: categoryId)
        .get();

    return querySnapshot.docs
        .map((doc) =>
            Recipe.fromFirestore(doc.data() as DocumentSnapshot<Object?>))
        .toList();
  }
}
