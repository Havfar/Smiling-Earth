import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_client.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';

part 'pledge_state.dart';

class PledgeCubit extends Cubit<PledgeState> {
  final _client = PledgeClient();
  PledgeCubit() : super(PledgeInitial());

  void getTeamPledge(int teamId) {
    try {
      _client
          .getTeamPledges(teamId)
          .then((pledges) => emit(RetrievedPledges(pledges)));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void getUserPledges(int userId) {
    try {
      _client
          .getUserPledges(userId)
          .then((pledges) => emit(RetrievedPledges(pledges)));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void getMyUserPledges() {
    try {
      _client
          .getMyUserPledges()
          .then((pledges) => emit(RetrievedPledges(pledges)));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void getNotJoinedPledges() {
    try {
      _client
          .getNotJoinedPledges()
          .then((pledges) => emit(RetrievedPledges(pledges)));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void getPledes() {
    try {
      _client.getPledges().then((pledges) => emit(RetrievedPledges(pledges)));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void makePledge(List<int> pledges) {
    try {
      _client.createUserPledge(pledges).then((value) => emit(PledgesMade()));
    } catch (e) {
      emit(ErrorRetrievingPledges(e.toString()));
    }
  }

  void deletePledge(int pledgeId) {
    try {
      emit(PledgesDeleting());
      _client.deleteUserPledge(pledgeId).then((statusOk) {
        if (statusOk) {
          emit(PledgesDeleted());
        } else {
          emit(PledgesDeletingError());
        }
      });
    } catch (e) {
      emit(PledgesDeletingError());
    }
  }
}
