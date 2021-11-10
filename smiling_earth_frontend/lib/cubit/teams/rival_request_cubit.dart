import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/teams/teams_client.dart';
import 'package:smiling_earth_frontend/models/rivals.dart';

part 'rival_request_state.dart';

class RivalRequestCubit extends Cubit<RivalRequestState> {
  RivalRequestCubit() : super(RivalRequestInitial());
  TeamsClient _client = TeamsClient();

  void getRequests(int teamId) {
    try {
      _client
          .getRivalRequests(teamId)
          .then((requests) => emit(RivalRequestRetrived(requests)));
    } catch (e) {
      emit(RivalRequestError(e.toString()));
    }
  }

  void sendRivalryRequests(SimpleRivalDto rivalry) {
    emit(RivalRequestLoading());
    try {
      _client
          .sendRivalryRequest(rivalry)
          .then((requests) => emit(RivalRequestSent()));
    } catch (e) {
      emit(RivalRequestError(e.toString()));
    }
  }

  void acceptRivalryRequests(RivalDto rivalry) {
    try {
      _client
          .updateRivalryRequest(rivalry)
          .then((requests) => emit(RivalRequestAccepted()));
    } catch (e) {
      emit(RivalRequestError(e.toString()));
    }
  }

  void declineRivalryRequests(RivalDto rivalry) {
    try {
      _client
          .deleteRivalryRequest(rivalry)
          .then((requests) => emit(RivalRequestDeclined()));
    } catch (e) {
      emit(RivalRequestError(e.toString()));
    }
  }
}
