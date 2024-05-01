abstract class PokeApiRepository {
  Future<Map<String, dynamic>> getPokemon(String name);
  Future<Map<String, dynamic>> getPokemonSpecies(String name);
}
