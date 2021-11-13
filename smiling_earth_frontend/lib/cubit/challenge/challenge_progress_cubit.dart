import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';

part 'challenge_progress_state.dart';

class ChallengeProgressCubit extends Cubit<ChallengeProgressState> {
  ChallengeProgressCubit() : super(ChallengeProgressInitial());

  final ChallengesClient _client = ChallengesClient();

  void getUserProgress(int challengeId) {
    try {
      _client
          .getChallengeProgress(challengeId)
          .then((data) => emit(RetrivedProgress(data[0], data[1], data[2])));
    } catch (e) {
      emit(RetrivedProgressError(e.toString()));
    }
  }

  void getTeamProgress(int challengeId, int teamId) {
    try {
      _client
          .getTeamChallengeProgress(challengeId, teamId)
          .then((data) => emit(RetrivedProgress(data[0], data[1], data[2])));
    } catch (e) {
      emit(RetrivedProgressError(e.toString()));
    }
  }
}
