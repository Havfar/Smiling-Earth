part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileRetrived extends ProfileState {
  final UserProfileDetailedDto profile;

  ProfileRetrived(this.profile);
}

class ProfileRetrivedError extends ProfileState {
  final String error;

  ProfileRetrivedError(this.error);
}
