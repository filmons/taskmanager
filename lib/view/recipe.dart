// import 'package:flutter/material.dart';
// import 'package:taskmanager/model/Recipe.dart';

// class RecipePage extends StatelessWidget {
//   const RecipePage({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recipe Page'),
//       ),
//       body: const Center(
//         child: Text('This is the Recipe Page'),
//       ),
//     );
//   }
// }
// Inside recipe.dart
// Inside recipe.dart
import 'package:flutter/material.dart';
import 'package:taskmanager/model/Recipe.dart';
import '../model/Category.dart'; // Adjust the import path as necessary
import '../controller/recipe_controller.dart';

class RecipePage extends StatelessWidget {
  final Category category;
  final RecipeController recipeController = RecipeController();

  RecipePage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: recipeController.fetchRecipesByCategoryId(category.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching recipes'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Recipe recipe = snapshot.data![index];
                return ListTile(
                    // title: Text(recipe.title),
                    );
              },
            );
          }
        },
      ),
    );
  }
}




// // this is the recipe page
// import 'package:flutter/material.dart';
// import 'package:taskmanager/model/Recipe.dart';

// class NewRecipePage extends StatefulWidget {
//   const NewRecipePage({Key? key}) : super(key: key);

//   @override
//   _NewRecipePageState createState() => _NewRecipePageState();
// }

// class _NewRecipePageState extends State<NewRecipePage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _imgUrlController = TextEditingController();
//   final TextEditingController _servingController = TextEditingController();
//   final TextEditingController _durationController = TextEditingController();
//   final TextEditingController _ownerController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('New Recipe'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextFormField(
//               controller: _imgUrlController,
//               decoration: InputDecoration(labelText: 'Image URL'),
//             ),
//             TextFormField(
//               controller: _servingController,
//               decoration: InputDecoration(labelText: 'Serving'),
//             ),
//             TextFormField(
//               controller: _durationController,
//               decoration: InputDecoration(labelText: 'Duration'),
//             ),
//             TextFormField(
//               controller: _ownerController,
//               decoration: InputDecoration(labelText: 'Owner'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Create a new Recipe object using the input values
//                 Recipe newRecipe = Recipe(
//                   id: 'generated_id', // Generate an id or leave it empty
//                   name: _nameController.text,
//                   imgUrl: _imgUrlController.text,
//                   serving: int.tryParse(_servingController.text) ?? 0,
//                   duration: _durationController.text,
//                   owner: _ownerController.text,
//                   // You can handle other properties similarly
//                 );

//                 // Add code here to save or submit the new recipe
//               },
//               child: Text('Save Recipe'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up the TextEditingController instances
//     _nameController.dispose();
//     _imgUrlController.dispose();
//     _servingController.dispose();
//     _durationController.dispose();
//     _ownerController.dispose();
//     super.dispose();
//   }
// }
