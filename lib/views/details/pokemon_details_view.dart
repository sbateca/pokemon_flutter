import 'package:flutter/material.dart';
import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/utils.dart';
import 'package:poke_app/views/views.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({super.key});

  @override
  _PokemonDetailsViewState createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
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
            _PokemonHeader(pokemon: pokemon),
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

class _PokemonHeader extends StatefulWidget {
  const _PokemonHeader({
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  _PokemonHeaderState createState() => _PokemonHeaderState();
}

class _PokemonHeaderState extends State<_PokemonHeader> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pokemonImagesList = [
      widget.pokemon.sprites.frontDefault,
      widget.pokemon.sprites.backDefault
    ];
    return Stack(
      children: [
        Container(
          height: 200,
          color: Colors.green,
          padding: const EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Image(
            image: NetworkImage(pokemonImagesList[_currentIndex]),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => getNewIndex(pokemonImagesList.length),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => getNewIndex(pokemonImagesList.length),
          ),
        ),
      ],
    );
  }

  void getNewIndex(int pokemonListLength) {
    int listSize = pokemonListLength;
    if (_currentIndex < listSize - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        _currentIndex = 0;
      });
    }
  }
}
