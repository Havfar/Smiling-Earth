part of 'join_team_cubit.dart';

@immutable
abstract class JoinTeamState {}

class JoinTeamInitial extends JoinTeamState {}

class JoiningTeam extends JoinTeamState {}

class TeamJoined extends JoinTeamState {
  final int value;
  TeamJoined(this.value);
}

class TeamJoinedError extends JoinTeamState {
  final String error;

  TeamJoinedError(this.error);
}
