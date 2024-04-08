import 'package:flutter/material.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/utils.dart';
import 'package:poke_app/views/views.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key});

  @override
  PokemonDetailsViewState createState() => PokemonDetailsViewState();
}

class PokemonDetailsViewState extends State<PokemonDetailsView> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PokemonHeader(pokemon: pokemon),
            Text(
              capitalize(pokemon.name),
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Weight: ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${pokemon.weight} Pounds",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Stats & Types: ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Categories(categories: const ["Stats", "Types"], pokemon: pokemon),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: () async {
          result = await takePicture(pokemon.name);
          if (result.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result),
                duration: const Duration(seconds: 5),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: const Icon(Icons.camera_alt_rounded),
      ),
    );
  }
}


