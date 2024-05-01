import 'package:dio/dio.dart';

class PokeApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getPokemon(String name) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      return response.data;
    } catch (e) {
      throw 'Failed to fetch Pokemon: $e';
    }
  }

  Future<Map<String, dynamic>> getPokemonSpecies(String name) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon-species/$name');
      return response.data;
    } catch (e) {
      throw 'Failed to fetch Pokemon species: $e';
    }
  }

  Future<Map<String, dynamic>> postData(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('https://your-api-endpoint.com', data: data);
      return response.data;
    } catch (e) {
      throw 'Failed to post data: $e';
    }
  }
}
