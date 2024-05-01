import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';

class PokemonNotifier extends StateNotifier<PokemonState> {
  final PokeApiRepository _repository;

  PokemonNotifier(this._repository) : super(const PokemonState.initial());

  Future<void> getPokemon(String name) async {
    try {
      // Set isLoading to true when initiating the request
      state = state.copyWith(isLoading: true);

      final pokemon = await _repository.getPokemon(name);
      final species = await _repository.getPokemonSpecies(name);

      // Update state with the retrieved data and set isLoading back to false
      state = PokemonState(pokemon: pokemon, species: species, isLoading: false);
    } catch (e) {
      debugPrint(e.toString());
      // If an error occurs, ensure isLoading is set back to false
      state = state.copyWith(isLoading: false);
    }
  }
}
