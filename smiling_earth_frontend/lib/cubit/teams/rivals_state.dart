part of 'rivals_cubit.dart';

abstract class RivalsState extends Equatable {
  const RivalsState();

  @override
  List<Object> get props => [];
}

class RivalsInitial extends RivalsState {}

class RivalsFetched extends RivalsState {
  final List<TeamsDto> rivals;

  RivalsFetched(this.rivals);
}

class RivalsError extends RivalsState {
  final String error;

  RivalsError(this.error);
}

// class NewRival extends RivalsState {}
// class RivalResponse extends RivalsState {}
