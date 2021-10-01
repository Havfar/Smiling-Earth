part of 'detailed_team_cubit.dart';

@immutable
abstract class DetailedTeamState {}

class DetailedTeamInitial extends DetailedTeamState {}

class RetrievedTeam extends DetailedTeamState {
  final TeamDetailedDto teams;

  RetrievedTeam(this.teams);
}

class ErrorRetrievingTeam extends DetailedTeamState {
  final String error;

  ErrorRetrievingTeam(this.error);
}
