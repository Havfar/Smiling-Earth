part of 'detailed_team_cubit.dart';

@immutable
abstract class DetailedTeamState {}

class DetailedTeamInitial extends DetailedTeamState {}

class RetrievedTeam extends DetailedTeamState {
  final TeamDetailedDto teams;

  RetrievedTeam(this.teams);
}

class RetrieveTeamMembers extends DetailedTeamState {
  final List<TeamMemberDto> members;

  RetrieveTeamMembers(this.members);
}

class ErrorRetrievingTeam extends DetailedTeamState {
  final String error;

  ErrorRetrievingTeam(this.error);
}
