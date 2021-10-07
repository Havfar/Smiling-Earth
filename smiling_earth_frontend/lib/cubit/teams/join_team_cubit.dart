import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_client.dart';

part 'join_team_state.dart';

class JoinTeamCubit extends Cubit<JoinTeamState> {
  final TeamsClient _client = TeamsClient();

  JoinTeamCubit() : super(JoinTeamInitial());

  void joinTeam(int teamId) {
    try {
      emit(JoiningTeam());
      _client.joinTeam(teamId).then((value) => emit(TeamJoined(value)));
    } catch (e) {
      emit(TeamJoinedError(e.toString()));
    }
  }
}
