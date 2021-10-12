import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/user/user_client.dart';
import 'package:smiling_earth_frontend/models/user.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  UserClient _client = UserClient();
  ProfileCubit() : super(ProfileInitial());

  void getProfile(int userId) {
    try {
      _client
          .getProfile(userId)
          .then((profile) => emit(ProfileRetrived(profile)));
    } catch (e) {
      emit(ProfileRetrivedError(e.toString()));
    }
  }
}
