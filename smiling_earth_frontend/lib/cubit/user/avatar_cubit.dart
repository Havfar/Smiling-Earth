import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/user/user_client.dart';
import 'package:smiling_earth_frontend/models/avatar.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final UserClient _client = UserClient();

  AvatarCubit() : super(AvatarInitial());

  void updateAvatar(Avatar avatar) {
    try {
      emit(UpdatingAvatar());
      _client.updateAvatar(avatar).then((responseCode) {
        if (responseCode == 200) {
          emit(AvatarUpdated());
        } else {
          emit(AvatarError(responseCode.toString()));
        }
      });
    } catch (e) {
      emit(AvatarError(e.toString()));
    }
  }
}
