import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';
import 'package:template_riverpod_go_router/widgets/widgets.dart';

class PokemonScreen extends ConsumerStatefulWidget {
  static PokemonScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const PokemonScreen();

  const PokemonScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends ConsumerState<PokemonScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonState = ref.watch(pokemonProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Enter Pokemon Name',
              ),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                final pokemonName = _searchController.text.trim();
                if (pokemonName.isNotEmpty) {
                  ref.read(pokemonProvider.notifier).getPokemon(pokemonName);
                }
              },
              child: const Text('Search'),
            ),
            const Gap(20),
            if (pokemonState.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (pokemonState.pokemon != null && pokemonState.species != null)
              PokemonCard(pokemon: pokemonState.pokemon!, species: pokemonState.species!)
            else
              const Center(
                child: Text('Pokemon not found'), // Display error message
              ),
          ],
        ),
      ),
    );
  }
}