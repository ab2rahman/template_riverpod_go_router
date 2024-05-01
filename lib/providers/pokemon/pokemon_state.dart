import 'package:equatable/equatable.dart';

class PokemonState extends Equatable {
  final Map<String, dynamic>? pokemon;
  final Map<String, dynamic>? species;
  final bool isLoading;

  const PokemonState({
    this.pokemon,
    this.species,
    this.isLoading = false,
  });

  const PokemonState.initial()
      : pokemon = null,
        species = null,
        isLoading = false;

  PokemonState copyWith({
    Map<String, dynamic>? pokemon,
    Map<String, dynamic>? species,
    bool? isLoading,
  }) {
    return PokemonState(
      pokemon: pokemon ?? this.pokemon,
      species: species ?? this.species,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [pokemon, species, isLoading];
}
