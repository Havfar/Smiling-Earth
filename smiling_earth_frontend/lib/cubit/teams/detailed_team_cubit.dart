import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_client.dart';
import 'package:smiling_earth_frontend/models/teams.dart';

part 'detailed_team_state.dart';

class DetailedTeamCubit extends Cubit<DetailedTeamState> {
  DetailedTeamCubit() : super(DetailedTeamInitial());
  final _client = TeamsClient();

  void getTeams(int id) {
    try {
      _client.getTeam(id).then((teams) => emit(RetrievedTeam(teams)));
    } catch (e) {
      emit(ErrorRetrievingTeam(e.toString()));
    }
  }
}
