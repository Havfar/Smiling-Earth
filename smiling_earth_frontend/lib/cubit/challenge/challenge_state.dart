part of 'challenge_cubit.dart';

abstract class ChallengeState extends Equatable {
  const ChallengeState();

  @override
  List<Object> get props => [];
}

class ChallengeInitial extends ChallengeState {}

class RetrivingChallenges extends ChallengeState {}

class RetrievedChallenges extends ChallengeState {
  final List<ChallengeDto> challenges;

  RetrievedChallenges(this.challenges);
}

class RetrievedJoinedChallenges extends ChallengeState {
  final List<JoinedChallengeDto> challenges;

  RetrievedJoinedChallenges(this.challenges);
}

class RetrievedDetailedChallenge extends ChallengeState {
  final DetailedChallengeDto challenge;

  RetrievedDetailedChallenge(this.challenge);
}

class RetrievedChallengesError extends ChallengeState {
  final String error;
  RetrievedChallengesError(this.error);
}
