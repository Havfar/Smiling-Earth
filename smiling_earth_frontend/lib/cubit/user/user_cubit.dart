import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/user/user_client.dart';
import 'package:smiling_earth_frontend/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserClient _client = UserClient();
  UserCubit() : super(UserInitial());

  void getFollowers() {
    try {
      _client.getFollowers().then((users) => emit(UsersRetrived(users)));
    } catch (e) {
      emit(UsersRetrivedError(e.toString()));
    }
  }

  void getFollowing() {
    try {
      _client.getFollowing().then((users) => emit(UsersRetrived(users)));
    } catch (e) {
      emit(UsersRetrivedError(e.toString()));
    }
  }

  void getNotFollowing() {
    try {
      _client.getNotFollowing().then((users) => emit(UsersRetrived(users)));
    } catch (e) {
      emit(UsersRetrivedError(e.toString()));
    }
  }
}
