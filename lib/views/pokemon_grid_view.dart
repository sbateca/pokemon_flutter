import 'package:flutter/material.dart';
import 'package:poke_app/provider/pokemon_provider.dart';
import 'package:poke_app/widgets/pokemon_action_button.dart';
import 'package:poke_app/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';


class PokemonGridView extends StatefulWidget {
  const PokemonGridView({super.key});

  @override
  State<PokemonGridView> createState() => _PokemonGridViewState();
}

class _PokemonGridViewState extends State<PokemonGridView> {
  
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    int pokemonIdCounter = pokemonProvider.pokemons.length;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final crossAxisCount = isPortrait ? 2 : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Grid View'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return PokemonGridCard(
            pokemon: pokemonProvider.pokemons[index],
          );
        },
        itemCount: pokemonIdCounter,
      ),
      floatingActionButton: CustomFloatingActionButton(
          icon: Icons.add,
          onPressed: () {
            pokemonProvider.addPokemon(pokemonIdCounter+1, 2);
            pokemonProvider.pokemonIdCounter = pokemonIdCounter + 2;
            setState(() {});
          }),
    );
  }
}
