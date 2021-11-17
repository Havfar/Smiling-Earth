part of 'follow_cubit.dart';

abstract class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object> get props => [];
}

class FollowInitial extends FollowState {}

class FollowRequestSending extends FollowState {}

class FollowRequestApproved extends FollowState {}

class FollowRequestError extends FollowState {}
