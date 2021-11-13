part of 'challenge_progress_cubit.dart';

abstract class ChallengeProgressState extends Equatable {
  const ChallengeProgressState();

  @override
  List<Object> get props => [];
}

class ChallengeProgressInitial extends ChallengeProgressState {}

class RetrivedProgress extends ChallengeProgressState {
  final int progress;
  final int score;
  final int goal;

  RetrivedProgress(this.progress, this.score, this.goal);
}

class RetrivedProgressError extends ChallengeProgressState {
  final String error;

  RetrivedProgressError(this.error);
}
