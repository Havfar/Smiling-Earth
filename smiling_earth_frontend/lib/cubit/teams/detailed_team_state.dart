part of 'detailed_team_cubit.dart';

@immutable
abstract class DetailedTeamState {}

class DetailedTeamInitial extends DetailedTeamState {}

class RetrievedTeam extends DetailedTeamState {
  final TeamDetailedDto teams;

  RetrievedTeam(this.teams);
}

class RetrievedTeamEmission extends DetailedTeamState {
  final double energyEmission;
  final double transportEmission;

  RetrievedTeamEmission(this.energyEmission, this.transportEmission);
}

class RetrieveTeamMembers extends DetailedTeamState {
  final List<TeamMemberDto> members;

  List<TeamMemberDto> getLeaderboard() {
    members.sort((a, b) {
      return a.emissions.compareTo(b.emissions);
    });
    return members;
  }

  RetrieveTeamMembers(this.members);
}

class ErrorRetrievingTeam extends DetailedTeamState {
  final String error;

  ErrorRetrievingTeam(this.error);
}
