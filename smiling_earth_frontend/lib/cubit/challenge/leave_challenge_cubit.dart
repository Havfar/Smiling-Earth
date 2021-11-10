import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/challenge/challenge_client.dart';

part 'leave_challenge_state.dart';

class LeaveChallengeCubit extends Cubit<LeaveChallengeState> {
  LeaveChallengeCubit() : super(LeaveChallengeInitial());
  ChallengesClient _client = ChallengesClient();

  void leaveTeamChallenge(int teamId, int challengeId) {
    emit(LeaveChallengeSending());
    try {
      _client
          .leaveTeamChallenge(challengeId, teamId)
          .then((value) => emit(LeaveChallengeLeft()));
    } catch (e) {
      emit(LeaveChallengeError(e.toString()));
    }
  }
}
