import 'dart:io';

import 'package:flutter/material.dart';

import 'package:poke_app/model/pokemon_model.dart';
import 'package:poke_app/utils/file_system.dart';

class PokemonHeader extends StatefulWidget {
  const PokemonHeader({super.key, 
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  PokemonHeaderState createState() => PokemonHeaderState();
}

class PokemonHeaderState extends State<PokemonHeader> {
  var _currentIndex = 0;
  bool defaultImages = true;
  List<dynamic> pokemonImagesList = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
    _loadImages();
  }

  Future<void> _loadImages() async {
    pokemonImagesList = await buildImagesList(widget.pokemon.name);
    if(pokemonImagesList.isEmpty){
      pokemonImagesList = [
        widget.pokemon.sprites.frontDefault,
        widget.pokemon.sprites.backDefault
      ];
    }else{
      defaultImages = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: buildImagesList(widget.pokemon.name),
      builder: (context, snapshot) => _buildPageView(),
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pokemonImagesList.length,
            itemBuilder: (context, index) {
              return buildImage(context, index);
            },
          ),
          Positioned(
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Image buildImage(BuildContext context, int index) {
    if(defaultImages){
      return Image.network(widget.pokemon.sprites.frontDefault);
    }else{
      return Image.file(
                File(pokemonImagesList[index]),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Container(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                    child: const Center(
                      child: Text('Image not found',
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              );
    }
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < pokemonImagesList.length; i++) {
      indicators.add(
        Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == i ? Colors.blue : Colors.grey,
          ),
        ),
        
      );
    }
    return indicators;
  }

  Future<List<String>> buildImagesList(String pokemonName) async {
    List<String> imagesList =
        await FileSystemUtils.listExternalFolder(pokemonName.toLowerCase());
    return imagesList;
  }
}