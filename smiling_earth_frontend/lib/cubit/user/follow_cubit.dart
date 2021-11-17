import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/user/user_client.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  UserClient _client = UserClient();

  FollowCubit() : super(FollowInitial());

  void follow(int userId) {
    emit(FollowRequestSending());
    try {
      _client.follow(userId).then((value) {
        if (value) {
          emit(FollowRequestApproved());
        } else {
          emit(FollowRequestError());
        }
      });
    } catch (e) {
      emit(FollowRequestError());
    }
  }

  void unfollow(int userId) {
    emit(FollowRequestSending());
    try {
      _client.unfollow(userId).then((value) {
        if (value) {
          emit(FollowRequestApproved());
        } else {
          emit(FollowRequestError());
        }
      });
    } catch (e) {
      emit(FollowRequestError());
    }
  }
}
