import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';
import 'package:smiling_earth_frontend/models/challenge.dart';

part 'challenge_state.dart';

class ChallengeCubit extends Cubit<ChallengeState> {
  final ChallengesClient _client = ChallengesClient();
  ChallengeCubit() : super(ChallengeInitial());

  void getChallenges() {
    emit(RetrivingChallenges());
    try {
      _client
          .getChallenges()
          .then((challenges) => emit(RetrievedChallenges(challenges)));
    } catch (e) {
      emit(RetrievedChallengesError(e.toString()));
    }
  }

  void getJoinedChallenges() {
    emit(RetrivingChallenges());
    try {
      _client
          .getJoinedChallenges()
          .then((challenges) => emit(RetrievedJoinedChallenges(challenges)));
    } catch (e) {
      emit(RetrievedChallengesError(e.toString()));
    }
  }

  void getCompletedChallenges(int userId) {
    try {
      _client
          .getCompletedChallenges(userId)
          .then((challenges) => emit(RetrievedChallenges(challenges)));
    } catch (e) {
      emit(RetrievedChallengesError(e.toString()));
    }
  }

  void getDetailedChallenge(int challengeId) {
    emit(RetrivingChallenges());
    try {
      _client
          .getChallengeDetailed(challengeId)
          .then((challenge) => emit(RetrievedDetailedChallenge(challenge)));
    } catch (e) {
      emit(RetrievedChallengesError(e.toString()));
    }
  }
}
