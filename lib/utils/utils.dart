import 'package:flutter/material.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/views/views.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

String getAssetImage(String type, String name) {
  return "assets/${type}_types/$name.png";
}

Widget buildCategoryFromContext(BuildContext context) {
    final Map<String, dynamic> arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Pokemon pokemon = arguments["pokemon"] as Pokemon;
    final String category = arguments["category"] as String;
    return Category(pokemon: pokemon, category: category);
  }