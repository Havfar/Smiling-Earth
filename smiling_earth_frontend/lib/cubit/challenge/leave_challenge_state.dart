part of 'leave_challenge_cubit.dart';

abstract class LeaveChallengeState extends Equatable {
  const LeaveChallengeState();

  @override
  List<Object> get props => [];
}

class LeaveChallengeInitial extends LeaveChallengeState {}

class LeaveChallengeLeft extends LeaveChallengeState {}

class LeaveChallengeSending extends LeaveChallengeState {}

class LeaveChallengeError extends LeaveChallengeState {
  final String error;

  LeaveChallengeError(this.error);
}
