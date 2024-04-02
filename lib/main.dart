import 'package:flutter/material.dart';

import 'package:poke_app/provider/pokemon_provider.dart';
import 'package:poke_app/utils/utils.dart';
import 'package:poke_app/views/views.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PokemonProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      initialRoute: "/splashScreen",
      routes: {
        "/splashScreen": (context) => const SplashScreen(),
        "/home": (context) => const PokemonGridView(),
        "/detailsView": (context) => const PokemonDetailsView(),
        "/category": (context) => buildCategoryFromContext(context),
      },
    );
  }
}
