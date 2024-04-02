import 'package:flutter/material.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/utils.dart';

class Categories extends StatelessWidget {

  final List<String> categories; 
  final Pokemon pokemon;
  const Categories({super.key, required this.categories, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Column(
    children: categories.map((category) {
      return InkWell(
        child: Card(
          child: ListTile(
            leading: Image(
              width: 25,
              height: 25,
                image: Image.asset('assets/categories/${category.toLowerCase()}.png').image,
            ),
            title: 
                Text(
                  capitalize(category),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/category", arguments: {"pokemon": pokemon, "category": category});
      }
      ); 
    }).toList(),
  ); 
  }
}
