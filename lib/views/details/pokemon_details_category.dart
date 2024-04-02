import 'package:flutter/material.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/utils.dart';

class Category extends StatelessWidget {
  final Pokemon pokemon;
  final String category;

  const Category({super.key, required this.pokemon, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${capitalize(pokemon.name)}\'s $category'),
      ),
      body: category == "Stats"
          ? buildStatTileRow(pokemon.stats)
          : buildTCategoryTypeTileRow(pokemon.types),
    );
  }
}

Widget buildTCategoryTypeTileRow(List<Type> types) {
  return Column(
    children: types.map((type) {
      return Card(
        child: ListTile(
          leading: Image(
            width: 25,
            height: 25,
            image: AssetImage(getAssetImage('pokemon',
                type.type.name.replaceFirst(RegExp(r'(\-)'), '_'))),
          ),
          title: Row(
            children: [
              Text(
                capitalize(type.type.name),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
      ));
    }).toList(),
  );
}

Widget buildStatTileRow(List<StatElement> stats) {
  return Column(
    children: stats.map((stat) {
      return Card(
        child: ListTile(
          leading: Image(
            width: 25,
            height: 25,
            image: AssetImage(getAssetImage('stats',
                stat.stat.name.replaceFirst(RegExp(r'(\-)'), '_'))),
          ),
          title: Row(
            children: [
              Text(
                capitalize(stat.stat.name),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        trailing: Text(
          stat.baseStat.toString(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ));
    }).toList(),
  );
}
