import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/providers/providers.dart';

final pokemonProvider =
    StateNotifierProvider<PokemonNotifier, PokemonState>((ref) {
  final repository = ref.watch(pokeApiRepositoryProvider);
  return PokemonNotifier(repository);
});