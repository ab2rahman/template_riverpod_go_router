import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/repositories/repositories.dart';

final pokeApiRepositoryProvider = Provider<PokeApiRepository>((ref) {
  return PokeApiRepositoryImpl();
});

final pokemonProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, name) async {
  final pokeApiRepository = ref.watch(pokeApiRepositoryProvider);
  return pokeApiRepository.getPokemon(name);
});

final pokemonSpeciesProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, name) async {
  final pokeApiRepository = ref.watch(pokeApiRepositoryProvider);
  return pokeApiRepository.getPokemonSpecies(name);
});
