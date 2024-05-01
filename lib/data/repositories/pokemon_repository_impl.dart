import 'package:template_riverpod_go_router/data/data.dart';
import 'package:template_riverpod_go_router/configs/configs.dart'; // Adjust this import based on your project structure

class PokeApiRepositoryImpl implements PokeApiRepository {
  final PokeApiService _pokeApiService = PokeApiService(); // Create an instance of PokeApiService

  @override
  Future<Map<String, dynamic>> getPokemon(String name) async {
    try {
      return await _pokeApiService.getPokemon(name);
    } catch (e) {
      throw 'Failed to get Pokemon: $e';
    }
  }

  @override
  Future<Map<String, dynamic>> getPokemonSpecies(String name) async {
    try {
      return await _pokeApiService.getPokemonSpecies(name);
    } catch (e) {
      throw 'Failed to get Pokemon species: $e';
    }
  }
}
