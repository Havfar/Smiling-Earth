part of 'rival_request_cubit.dart';

abstract class RivalRequestState extends Equatable {
  const RivalRequestState();

  @override
  List<Object> get props => [];
}

class RivalRequestInitial extends RivalRequestState {}

class RivalRequestLoading extends RivalRequestState {}

class RivalRequestSent extends RivalRequestState {}

class RivalRequestRetrived extends RivalRequestState {
  final List<RivalDto> rivalRequests;

  RivalRequestRetrived(this.rivalRequests);
}

class RivalRequestAccepted extends RivalRequestState {}

class RivalRequestPended extends RivalRequestState {}

class RivalRequestError extends RivalRequestState {
  final String error;

  RivalRequestError(this.error);
}

class RivalRequestDeclined extends RivalRequestState {}
