part of 'avatar_cubit.dart';

abstract class AvatarState extends Equatable {
  const AvatarState();

  @override
  List<Object> get props => [];
}

class AvatarInitial extends AvatarState {}

class UpdatingAvatar extends AvatarState {}

class AvatarUpdated extends AvatarState {}

class AvatarError extends AvatarState {
  final String error;

  AvatarError(this.error);
}
