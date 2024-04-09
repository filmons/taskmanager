// import 'package:cloud_firestore/cloud_firestore.dart';

// class Recipe {
//   late String id;
//   late String name;
//   late String imgUrl;
//   late int serving;
//   late String duration;
//   late String owner;
//   List<Step>? steps;
//   List<Ingredient>? ingredients;
//   List<Tag>? tags;
//   List<String>? readers;
//   List<String>? editors;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Recipe({
//     required this.id,
//     required this.name,
//     required this.imgUrl,
//     required this.serving,
//     required this.duration,
//     required this.owner,
//     this.steps,
//     this.ingredients,
//     this.tags,
//     this.readers,
//     this.editors,
//     this.createdAt,
//     this.updatedAt,
//   });
// }

// class Step {
//   late String description;

//   Step({
//     required this.description,
//   });
// }

// class Ingredient {
//   late String name;
//   late String volume;

//   Ingredient({
//     required this.name,
//     required this.volume,
//   });
// }

// class Tag {
//   late String name;

//   Tag({
//     required this.name,
//   });
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class Recipe {
  late String id;
  late String name;
  late String imgUrl;
  late int serving;
  late String duration;
  late String owner;
  List<Step>? steps;
  List<Ingredient>? ingredients;
  List<Tag>? tags;
  List<String>? readers;
  List<String>? editors;
  DateTime? createdAt;
  DateTime? updatedAt;

  Recipe({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.serving,
    required this.duration,
    required this.owner,
    this.steps,
    this.ingredients,
    this.tags,
    this.readers,
    this.editors,
    this.createdAt,
    this.updatedAt,
  });

  // Example implementation of fromFirestore
  factory Recipe.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;

    // Example conversion for 'steps', 'ingredients', and 'tags'
    // Adjust according to how these are stored in Firestore
    List<Step>? steps = data['steps'] != null
        ? List.from(data['steps'])
            .map((step) => Step(description: step['description']))
            .toList()
        : null;
    List<Ingredient>? ingredients = data['ingredients'] != null
        ? List.from(data['ingredients'])
            .map((ingredient) => Ingredient(
                name: ingredient['name'], volume: ingredient['volume']))
            .toList()
        : null;
    List<Tag>? tags = data['tags'] != null
        ? List.from(data['tags']).map((tag) => Tag(name: tag['name'])).toList()
        : null;

    return Recipe(
      id: doc.id,
      name: data['name'],
      imgUrl: data['imgUrl'],
      serving: data['serving'],
      duration: data['duration'],
      owner: data['owner'],
      steps: steps,
      ingredients: ingredients,
      tags: tags,
      readers: List<String>.from(data['readers'] ?? []),
      editors: List<String>.from(data['editors'] ?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
    );
  }
}

class Step {
  late String description;

  Step({required this.description});
}

class Ingredient {
  late String name;
  late String volume;

  Ingredient({required this.name, required this.volume});
}

class Tag {
  late String name;

  Tag({required this.name});
}
