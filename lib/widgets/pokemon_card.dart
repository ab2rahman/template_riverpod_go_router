import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final Map<String, dynamic> pokemon;
  final Map<String, dynamic> species;

  const PokemonCard({Key? key, required this.pokemon, required this.species})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(pokemon['name']),
        subtitle: Text(
            'Height: ${pokemon['height']}, Weight: ${pokemon['weight']}, Habitat: ${species['habitat']['name']}'),
        leading: Image.network(pokemon['sprites']['front_default']),
      ),
    );
  }
}
