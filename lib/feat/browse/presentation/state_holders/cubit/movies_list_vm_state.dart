part of 'movies_list_vm_cubit.dart';

sealed class MoviesListVmState extends Equatable {
  const MoviesListVmState();

  @override
  List<Object> get props => [];
}

final class MoviesListVmInitial extends MoviesListVmState {}
