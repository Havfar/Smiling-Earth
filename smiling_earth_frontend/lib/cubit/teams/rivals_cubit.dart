import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_client.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';

part 'rivals_state.dart';

class RivalsCubit extends Cubit<RivalsState> {
  RivalsCubit() : super(RivalsInitial());
  final TeamsClient _client = TeamsClient();

  void getRivals(int teamId) {
    emit(RivalsInitial());
    try {
      _client.getRivals(teamId).then((rivals) => emit(RivalsFetched(rivals)));
    } catch (e) {
      emit(RivalsError(e.toString()));
    }
  }
}
