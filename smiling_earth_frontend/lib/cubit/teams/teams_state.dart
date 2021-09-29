part of 'teams_cubit.dart';

@immutable
abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class RetrievedTeams extends TeamsState {
  final List<TeamsDto> teams;

  RetrievedTeams(this.teams);
}

class ErrorRetrievingTeams extends TeamsState {
  final String error;

  ErrorRetrievingTeams(this.error);
}
