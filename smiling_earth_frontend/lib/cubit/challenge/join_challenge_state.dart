part of 'join_challenge_cubit.dart';

abstract class JoinChallengeState extends Equatable {
  const JoinChallengeState();

  @override
  List<Object> get props => [];
}

class JoinChallengeInitial extends JoinChallengeState {}

class JoiningChallenge extends JoinChallengeState {}

class ChallengeJoined extends JoinChallengeState {
  final int value;
  ChallengeJoined(this.value);
}

class ChallengeJoinedError extends JoinChallengeState {
  final String error;

  ChallengeJoinedError(this.error);
}
