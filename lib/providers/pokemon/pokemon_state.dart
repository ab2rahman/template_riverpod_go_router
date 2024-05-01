import 'package:equatable/equatable.dart';

class PokemonState extends Equatable {
  final Map<String, dynamic>? pokemon;
  final Map<String, dynamic>? species;
  final bool isLoading;
  final String errorMessage;

  const PokemonState({
    this.pokemon,
    this.species,
    this.isLoading = false,
    this.errorMessage = '',
  });

  const PokemonState.initial()
      : pokemon = null,
        species = null,
        isLoading = false,
        errorMessage = '';

  PokemonState copyWith({
    Map<String, dynamic>? pokemon,
    Map<String, dynamic>? species,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PokemonState(
      pokemon: pokemon ?? this.pokemon,
      species: species ?? this.species,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [pokemon, species, isLoading, errorMessage];
}
