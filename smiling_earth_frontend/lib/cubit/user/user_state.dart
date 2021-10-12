part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class RetrievingUser extends UserState {}

class UsersRetrived extends UserState {
  final List<UserProfileDto> users;

  UsersRetrived(this.users);
}

class UsersRetrivedError extends UserState {
  final String error;

  UsersRetrivedError(this.error);
}
