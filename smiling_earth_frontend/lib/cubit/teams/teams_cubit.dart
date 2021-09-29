import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_client.dart';
import 'package:smiling_earth_frontend/models/teams.dart';

part 'teams_state.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsInitial());
  final _client = TeamsClient();

  void getTeams() {
    try {
      _client.getTeams().then((teams) => emit(RetrievedTeams(teams)));
    } catch (e) {
      emit(ErrorRetrievingTeams(e.toString()));
    }
  }

  void getJoinedTeams() {
    try {
      _client.getJoinedTeams().then((teams) => emit(RetrievedTeams(teams)));
    } catch (e) {
      emit(ErrorRetrievingTeams(e.toString()));
    }
  }
}
