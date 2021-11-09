import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';

part 'join_challenge_state.dart';

class JoinChallengeCubit extends Cubit<JoinChallengeState> {
  final ChallengesClient _client = ChallengesClient();
  JoinChallengeCubit() : super(JoinChallengeInitial());

  void joinChallenge(int challengeId) {
    try {
      emit(JoiningChallenge());
      _client
          .joinChallenge(challengeId)
          .then((value) => emit(ChallengeJoined(value)));
    } catch (e) {
      emit(ChallengeJoinedError(e.toString()));
    }
  }

  void joinTeamChallenge(int challengeId, int teamId) {
    try {
      emit(JoiningChallenge());
      _client
          .joinTeamChallenge(challengeId, teamId)
          .then((value) => emit(ChallengeJoined(value)));
    } catch (e) {
      emit(ChallengeJoinedError(e.toString()));
    }
  }
}
